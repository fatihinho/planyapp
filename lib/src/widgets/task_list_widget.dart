import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/services/firestore_service.dart';
import 'package:planyapp/src/utils/datetime_format_util.dart';
import 'package:planyapp/src/widgets/textstyles_widget.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  final int _index;
  final int _folderId;
  final List<DocumentSnapshot> _tasks;
  TaskList(this._index, this._folderId, this._tasks);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _firestoreService = FirestoreService();

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

  Future<bool> promptUser(
      DismissDirection direction, TaskProvider taskProvider) async {
    if (direction == DismissDirection.endToStart) {
      return await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Plan'ı silmek istediğinden emin misin?"),
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
                        onPressed: () {
                          _firestoreService.deleteTask(
                              widget._tasks[widget._index].id,
                              widget._folderId);
                          taskProvider.decreaseTotalTaskCount();
                          Navigator.of(context).pop(true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text('Plan Silindi'),
                            ),
                          );
                        },
                      )
                    ],
                  )) ??
          false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Dismissible(
      key: Key(widget._tasks[widget._index].id),
      background: _stackBehindDismiss(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => promptUser(direction, taskProvider),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: GestureDetector(
              onTap: () {
                _firestoreService
                    .updateTaskCompleted(widget._tasks[widget._index].id);
              },
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
