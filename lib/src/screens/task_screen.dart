import 'package:flutter/material.dart';
import 'package:planyapp/src/models/task_model.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/screens/task_adding_screen.dart';
import 'package:planyapp/src/widgets/task_list_widget.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  final int _folderId;
  final String _title;
  final Color _color;
  TaskScreen(this._folderId, this._title, this._color);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  var _searchTyped = false;
  var _appBarSearch = const TextField();
  var _searchIcon = const Icon(Icons.search);

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
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    List<Task> tasks = Provider.of<TaskProvider>(context).tasks;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: widget._color,
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
            width: screenWidth,
            height: screenHeight,
            color: widget._color,
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
              child: tasks
                      .where((element) => element.folderId == widget._folderId)
                      .isNotEmpty
                  ? ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        if (tasks[index].folderId == widget._folderId) {
                          if (_searchController.text.isEmpty) {
                            return TaskList(index, widget._folderId);
                          } else if (tasks[index].title.toLowerCase().contains(
                                  _searchController.text.toLowerCase()) ||
                              tasks[index].note.toLowerCase().contains(
                                  _searchController.text.toLowerCase())) {
                            return TaskList(index, widget._folderId);
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      })
                  : Center(
                      child: Icon(
                        Icons.add,
                        size: 148.0,
                        color: Colors.indigo.shade200,
                      ),
                    ),
              height: screenHeight * 0.75,
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
