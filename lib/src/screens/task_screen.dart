import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  Route _navigateToTaskAdding(int folderId) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TaskAddingScreen(folderId),
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
              child: StreamBuilder(
                  stream: _firestoreService.getTasks(),
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
                                      index, widget._folderId, tasks);
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
                                      index, widget._folderId, tasks);
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
                            Icons.add,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(_navigateToTaskAdding(widget._folderId));
        },
      ),
    );
  }
}
