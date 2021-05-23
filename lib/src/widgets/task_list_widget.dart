import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/screens/task_editing_screen.dart';
import 'package:planyapp/src/utils/datetime_format_util.dart';
import 'package:planyapp/src/widgets/textstyles_widget.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  final int _index;
  final bool _isSearchBarOpen;
  final List<DocumentSnapshot> _tasks;
  final Function _onTaskCompleted;
  final Function _deleteTask;
  final Function _editTask;
  TaskList(this._index, this._isSearchBarOpen, this._tasks,
      this._onTaskCompleted, this._deleteTask, this._editTask);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  Route _navigateToTaskEditing(String id, Function editTask) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TaskEditingScreen(id, editTask),
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

  Widget _deleteBackground() {
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

  Widget _editBackground() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0),
      color: Colors.orange,
      child: Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }

  Future<bool> promptUser(
      DismissDirection direction, TaskProvider taskProvider) async {
    if (direction == DismissDirection.endToStart) {
      return await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Not'u silmek istediğinden emin misin?"),
                    actions: [
                      ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        child: Text('İptal'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      ElevatedButton(
                        child: Text('Sil'),
                        onPressed: () => widget._deleteTask(
                            widget._tasks, widget._index, taskProvider),
                      )
                    ],
                  )) ??
          false;
    } else if (direction == DismissDirection.startToEnd) {
      Navigator.of(context).push(_navigateToTaskEditing(
          widget._tasks[widget._index].id, widget._editTask));
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Dismissible(
      key: Key(widget._tasks[widget._index].id),
      background: _editBackground(),
      secondaryBackground: _deleteBackground(),
      direction: widget._isSearchBarOpen
          ? DismissDirection.none
          : DismissDirection.horizontal,
      confirmDismiss: (direction) => promptUser(direction, taskProvider),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: GestureDetector(
              onTap: () =>
                  widget._onTaskCompleted(widget._tasks, widget._index),
              child: widget._tasks[widget._index].get('isCompleted')
                  ? TasksTextStyles.completedTaskLeading
                  : TasksTextStyles.uncompletedTaskLeading),
          title: Text(
            '${widget._tasks[widget._index].get('title')}',
            style: widget._tasks[widget._index].get('isCompleted')
                ? TasksTextStyles.completedTitleTextStyle
                : TasksTextStyles.uncompletedTitleTextStyle,
          ),
          subtitle: Text('${widget._tasks[widget._index].get('note')}',
              style: widget._tasks[widget._index].get('isCompleted')
                  ? TasksTextStyles.completedNoteStyle
                  : TasksTextStyles.uncompletedNoteStyle),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget._tasks[widget._index].get('year') != null
                  ? Text(
                      '${DateTimeFormat.formatDate(widget._tasks[widget._index].get('day'))}/${DateTimeFormat.formatDate(widget._tasks[widget._index].get('month'))}/${widget._tasks[widget._index].get('year')}',
                      style: widget._tasks[widget._index].get('isCompleted')
                          ? TasksTextStyles.completedDateTimeStyle
                          : TasksTextStyles.uncompletedDateTimeStyle)
                  : Text(''),
              widget._tasks[widget._index].get('hour') != null
                  ? Text(
                      '${DateTimeFormat.formatTime(widget._tasks[widget._index].get('hour'))}:${DateTimeFormat.formatTime(widget._tasks[widget._index].get('minute'))}',
                      style: widget._tasks[widget._index].get('isCompleted')
                          ? TasksTextStyles.completedDateTimeStyle
                          : TasksTextStyles.uncompletedDateTimeStyle)
                  : Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
