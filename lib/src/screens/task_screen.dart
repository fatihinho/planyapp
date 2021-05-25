import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/screens/task_adding_screen.dart';
import 'package:planyapp/src/services/firestore_service.dart';
import 'package:planyapp/src/utils/colors_util.dart';
import 'package:planyapp/src/widgets/task_list_widget.dart';

class TaskScreen extends StatefulWidget {
  final int _folderId;
  final String _title;
  final String _color;
  TaskScreen(this._folderId, this._title, this._color);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  var _searchTyped = false;
  var _appBarSearch = const TextField();
  var _searchIcon = const Icon(Icons.search);

  final _firestoreService = FirestoreService();

  final _searchController = TextEditingController();

  Route _navigateToTaskAdding(int folderId, Function addTask) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TaskAddingScreen(addTask),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        _searchTyped = !_searchTyped;
        this._searchIcon = Icon(Icons.close);
        if (_searchTyped) {
          this._appBarSearch = TextField(
              cursorColor: Colors.white54,
              autofocus: true,
              controller: _searchController,
              onChanged: (String value) {
                setState(() {});
              },
              style: TextStyle(color: Colors.white54),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54)),
                prefixIcon: Icon(Icons.search, color: Colors.white54),
                suffix: GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white54,
                    size: 20.0,
                  ),
                  onTap: () {
                    setState(() {
                      this._searchController.clear();
                    });
                  },
                ),
                hintText: 'Ara',
                hintStyle: TextStyle(color: Colors.white54),
              ));
        }
      } else {
        _searchTyped = !_searchTyped;
        this._searchIcon = Icon(Icons.search);
        _searchController.clear();
      }
    });
  }

  void _onTaskCompleted(List<DocumentSnapshot> tasks, int index) async {
    await _firestoreService.updateTaskCompleted(tasks[index].id);
    setState(() {});
  }

  void _addTask(
    TextEditingController titleController,
    TextEditingController noteController,
    DateTime? date,
    TimeOfDay? time,
    bool hasAlarm,
    TaskProvider taskProvider,
  ) async {
    if (hasAlarm) {
      if (date != null &&
          time != null &&
          (titleController.text.trim().isNotEmpty ||
              noteController.text.trim().isNotEmpty)) {
        await _firestoreService.addTask(
            UniqueKey().hashCode,
            titleController.text,
            noteController.text,
            date.day.toString(),
            date.month.toString(),
            date.year.toString(),
            time.hour.toString(),
            time.minute.toString(),
            hasAlarm,
            false,
            widget._folderId);
        taskProvider.increaseTotalTaskCount();
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text('Eksik Alan Mevcut!')));
      }
    } else {
      if (titleController.text.trim().isNotEmpty ||
          noteController.text.trim().isNotEmpty) {
        await _firestoreService.addTask(
            UniqueKey().hashCode,
            titleController.text,
            noteController.text,
            date?.day.toString(),
            date?.month.toString(),
            date?.year.toString(),
            time?.hour.toString(),
            time?.minute.toString(),
            hasAlarm,
            false,
            widget._folderId);
        taskProvider.increaseTotalTaskCount();
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text('Eksik Alan Mevcut!')));
      }
    }
    setState(() {});
  }

  void _editTask(
      String id,
      TextEditingController titleController,
      TextEditingController noteController,
      DateTime? date,
      TimeOfDay? time,
      bool hasAlarm) async {
    if (hasAlarm) {
      if (date != null &&
          time != null &&
          (titleController.text.trim().isNotEmpty ||
              noteController.text.trim().isNotEmpty)) {
        _firestoreService.editTask(
            id,
            titleController.text,
            noteController.text,
            date.day.toString(),
            date.month.toString(),
            date.year.toString(),
            time.hour.toString(),
            time.minute.toString(),
            hasAlarm);
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text('Eksik Alan Mevcut!')));
      }
    } else {
      if (titleController.text.trim().isNotEmpty ||
          noteController.text.trim().isNotEmpty) {
        _firestoreService.editTask(
            id,
            titleController.text,
            noteController.text,
            date?.day.toString(),
            date?.month.toString(),
            date?.year.toString(),
            time?.hour.toString(),
            time?.minute.toString(),
            hasAlarm);
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text('Eksik Alan Mevcut!')));
      }
    }
    setState(() {});
  }

  void _deleteTask(List<DocumentSnapshot> tasks, int index,
      TaskProvider taskProvider) async {
    await _firestoreService.deleteTask(tasks[index].id, widget._folderId);
    taskProvider.decreaseTotalTaskCount();
    Navigator.of(context).pop(true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Plan Silindi'),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorsUtil.colorNameToColor(widget._color),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: _searchIcon,
              onTap: () {
                _searchPressed();
              },
            ),
          ),
        ],
        title: _searchTyped ? _appBarSearch : null,
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: ColorsUtil.colorNameToColor(widget._color),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.folder,
                      color: Colors.white,
                      size: 36.0,
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        '${widget._title}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: FutureBuilder(
                  future: _firestoreService.getTasks(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Icon(Icons.error_outline));
                    } else {
                      final List<DocumentSnapshot> tasks = snapshot.data.docs;
                      if (tasks
                          .where((element) =>
                              element.get('folderId') == widget._folderId)
                          .isNotEmpty) {
                        return ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              if (tasks[index].get('folderId') ==
                                  widget._folderId) {
                                if (_searchController.text.isEmpty) {
                                  return TaskList(
                                      index,
                                      _searchTyped,
                                      tasks[index].get('hasAlarm'),
                                      tasks,
                                      _onTaskCompleted,
                                      _deleteTask,
                                      _editTask);
                                } else if (tasks[index]
                                        .get('title')
                                        .toLowerCase()
                                        .contains(_searchController.text
                                            .toLowerCase()) ||
                                    tasks[index]
                                        .get('note')
                                        .toLowerCase()
                                        .contains(_searchController.text
                                            .toLowerCase())) {
                                  return TaskList(
                                      index,
                                      _searchTyped,
                                      tasks[index].get('hasAlarm'),
                                      tasks,
                                      _onTaskCompleted,
                                      _deleteTask,
                                      _editTask);
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return Center(
                          child: Icon(
                            Icons.notes,
                            size: 148.0,
                            color: Colors.indigo.shade200,
                          ),
                        );
                      }
                    }
                  }),
              height: size.height * 0.75,
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        width: 72.0,
        height: 72.0,
        child: FloatingActionButton(
          backgroundColor: Colors.cyan,
          child: Icon(Icons.add, size: 48.0),
          onPressed: () {
            Navigator.of(context)
                .push(_navigateToTaskAdding(widget._folderId, _addTask));
          },
        ),
      ),
    );
  }
}
