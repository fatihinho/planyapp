import 'package:flutter/material.dart';
import 'package:planyapp/src/models/task_model.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/utils/datetime_format_util.dart';
import 'package:planyapp/src/widgets/textstyles_widget.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  final int _index;
  final int _folderId;
  TaskList(this._index, this._folderId);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
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
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    List<Task> tasks = Provider.of<TaskProvider>(context).tasks;

    return Dismissible(
      key: ObjectKey(tasks[widget._index]),
      background: _stackBehindDismiss(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          taskProvider.deleteTask(widget._index, widget._folderId);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent, content: Text('Plan Silindi')));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: GestureDetector(
              onTap: () {
                setState(() {
                  tasks[widget._index].isCompleted =
                      !tasks[widget._index].isCompleted;
                });
              },
              child: tasks[widget._index].isCompleted
                  ? TasksTextStyles.completedTaskLeading
                  : TasksTextStyles.uncompletedTaskLeading),
          title: Text(
            '${tasks[widget._index].title}',
            style: tasks[widget._index].isCompleted
                ? TasksTextStyles.completedTitleTextStyle
                : TasksTextStyles.uncompletedTitleTextStyle,
          ),
          subtitle: Text('${tasks[widget._index].note}',
              style: tasks[widget._index].isCompleted
                  ? TasksTextStyles.completedNoteStyle
                  : TasksTextStyles.uncompletedNoteStyle),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              tasks[widget._index].date != null
                  ? Text(
                      '${DateTimeFormat.formatDate(tasks[widget._index].date?.day)}/${DateTimeFormat.formatDate(tasks[widget._index].date?.month)}/${tasks[widget._index].date?.year}',
                      style: tasks[widget._index].isCompleted
                          ? TasksTextStyles.completedDateTimeStyle
                          : TasksTextStyles.uncompletedDateTimeStyle)
                  : Text(''),
              tasks[widget._index].time != null
                  ? Text(
                      '${DateTimeFormat.formatTime(tasks[widget._index].time?.hour)}:${DateTimeFormat.formatTime(tasks[widget._index].time?.minute)}',
                      style: tasks[widget._index].isCompleted
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
