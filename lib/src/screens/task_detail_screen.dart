import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/screens/task_editing_screen.dart';
import 'package:planyapp/src/utils/colors_util.dart';
import 'package:planyapp/src/utils/datetime_format_util.dart';
import 'package:planyapp/src/widgets/textstyles_widget.dart';
import 'package:provider/provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final int _index;
  final String _color;
  final Function _editTask;
  final Function _deleteTask;
  final List<DocumentSnapshot> _tasks;
  TaskDetailScreen(
      this._index, this._color, this._editTask, this._deleteTask, this._tasks);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  Route _navigateToTaskEditing(String id, bool hasAlarm, Function editTask) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TaskEditingScreen(id, hasAlarm, editTask),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
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

  double _getTitleFontSize() {
    var title = widget._tasks[widget._index].get('title');
    if (title.length <= 10) {
      return 28.0;
    } else if (title.length > 10 && title.length <= 20) {
      return 24.0;
    } else if (title.length > 20 && title.length <= 30) {
      return 20.0;
    } else if (title.length > 30 && title.length <= 40) {
      return 16.0;
    } else {
      return 12.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final taskProvider = Provider.of<TaskProvider>(context);

    int dateComp;
    DateTime dateTime = DateTime(
        int.parse(widget._tasks[widget._index].get('year') ?? 0.toString()),
        int.parse(widget._tasks[widget._index].get('month') ?? 0.toString()),
        int.parse(widget._tasks[widget._index].get('day') ?? 0.toString()),
        int.parse(widget._tasks[widget._index].get('hour') ?? 0.toString()),
        int.parse(widget._tasks[widget._index].get('minute') ?? 0.toString()));
    dateComp = DateTime.now().compareTo(dateTime);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorsUtil.colorNameToColor(widget._color),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        _navigateToTaskEditing(
                            widget._tasks[widget._index].id,
                            widget._tasks[widget._index].get('hasAlarm'),
                            widget._editTask));
                  },
                  child: Icon(Icons.edit)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                  onTap: () {
                    showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded,
                                      color: Colors.red),
                                  SizedBox(width: 2.0),
                                  Text("Uyar??",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              content: Text(
                                  "Not'u silmek istedi??inden emin misin?",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              actions: [
                                TextButton(
                                  child: Text('??ptal'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                  child: Text('Sil'),
                                  onPressed: () {
                                    widget._deleteTask(
                                        widget._tasks,
                                        widget._index,
                                        taskProvider,
                                        widget._tasks[widget._index]
                                                .get('channelId') ??
                                            -1);
                                    Navigator.of(context).pop(true);
                                  },
                                )
                              ],
                            ));
                  },
                  child: Icon(Icons.delete)),
            ),
            widget._tasks[widget._index].get('isCompleted')
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
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
                        Icons.topic,
                        color: Colors.white,
                        size: 36.0,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          '${widget._tasks[widget._index].get('title')}',
                          style: TextStyle(
                              fontSize: _getTitleFontSize(),
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
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child:
                      widget._tasks[widget._index].get('note').trim().isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget._tasks[widget._index].get('hasAlarm')
                                        ? Column(children: [
                                            Row(
                                              children: [
                                                dateComp >= 0
                                                    ? TasksTextStyles
                                                        .uncompletedPasiveAlarmIcon
                                                    : TasksTextStyles
                                                        .uncompletedActiveAlarmIcon,
                                                Text(
                                                  ' ${DateTimeFormat.formatDate(widget._tasks[widget._index].get('day'))}/${DateTimeFormat.formatDate(widget._tasks[widget._index].get('month'))}/${widget._tasks[widget._index].get('year')}, ',
                                                  style: dateComp >= 0
                                                      ? TasksTextStyles
                                                          .uncompletedPasiveDateTimeStyle
                                                      : TasksTextStyles
                                                          .uncompletedActiveDateTimeStyle,
                                                ),
                                                Text(
                                                  '${DateTimeFormat.formatTime(widget._tasks[widget._index].get('hour'))}:${DateTimeFormat.formatTime(widget._tasks[widget._index].get('minute'))}',
                                                  style: dateComp >= 0
                                                      ? TasksTextStyles
                                                          .uncompletedPasiveDateTimeStyle
                                                      : TasksTextStyles
                                                          .uncompletedActiveDateTimeStyle,
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 32.0,
                                              thickness: 1.0,
                                              color: Colors.black,
                                            )
                                          ])
                                        : Container(),
                                    Text(
                                      '${widget._tasks[widget._index].get('note')}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: Icon(Icons.notes,
                                  size: 148, color: Colors.indigo.shade200)),
                  height: size.height * 0.75),
            )
          ],
        ));
  }
}
