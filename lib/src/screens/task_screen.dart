import 'package:flutter/material.dart';
import 'package:planyapp/src/models/task_model.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/screens/task_adding_screen.dart';
import 'package:planyapp/src/utils/datetime_format_util.dart';
import 'package:planyapp/src/widgets/textstyles_widget.dart';
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

  Widget _stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    List<Task> tasks = Provider.of<TaskProvider>(context).tasks;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: widget._color,
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
                          return Dismissible(
                            key: ObjectKey(tasks[index]),
                            background: _stackBehindDismiss(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                taskProvider.deleteTask(
                                    index, widget._folderId);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Plan Silindi')));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tasks[index].isCompleted =
                                            !tasks[index].isCompleted;
                                      });
                                    },
                                    child: tasks[index].isCompleted
                                        ? TasksTextStyles.completedTaskLeading
                                        : TasksTextStyles
                                            .uncompletedTaskLeading),
                                title: Text(
                                  '${tasks[index].title}',
                                  style: tasks[index].isCompleted
                                      ? TasksTextStyles.completedTitleTextStyle
                                      : TasksTextStyles
                                          .uncompletedTitleTextStyle,
                                ),
                                subtitle: Text('${tasks[index].note}',
                                    style: tasks[index].isCompleted
                                        ? TasksTextStyles.completedNoteStyle
                                        : TasksTextStyles.uncompletedNoteStyle),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    tasks[index].date != null
                                        ? Text(
                                            '${DateTimeFormat.formatDate(tasks[index].date?.day)}/${DateTimeFormat.formatDate(tasks[index].date?.month)}/${tasks[index].date?.year}',
                                            style: tasks[index].isCompleted
                                                ? TasksTextStyles
                                                    .completedDateTimeStyle
                                                : TasksTextStyles
                                                    .uncompletedDateTimeStyle)
                                        : Text(''),
                                    tasks[index].time != null
                                        ? Text(
                                            '${DateTimeFormat.formatTime(tasks[index].time?.hour)}:${DateTimeFormat.formatTime(tasks[index].time?.minute)}',
                                            style: tasks[index].isCompleted
                                                ? TasksTextStyles
                                                    .completedDateTimeStyle
                                                : TasksTextStyles
                                                    .uncompletedDateTimeStyle)
                                        : Text(''),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })
                  : Center(
                      child: Icon(
                        Icons.add,
                        size: 148.0,
                        color: Colors.indigo[200],
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
