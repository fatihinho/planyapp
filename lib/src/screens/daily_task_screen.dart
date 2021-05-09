import 'package:flutter/material.dart';
import 'package:planyapp/src/models/task_model.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/utils/datetime_format_util.dart';
import 'package:planyapp/src/widgets/textstyles_widget.dart';
import 'package:provider/provider.dart';

class DailyTaskScreen extends StatefulWidget {
  @override
  _DailyTaskScreenState createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> {
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
    return Container(
      child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ObjectKey(tasks[index]),
              background: _stackBehindDismiss(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  taskProvider.deleteTask(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text('Deleted $index')));
              },
              child: ListTile(
                leading: GestureDetector(
                    onTap: () {
                      setState(() {
                        tasks[index].isCompleted = !tasks[index].isCompleted;
                      });
                    },
                    child: tasks[index].isCompleted
                        ? TasksTextStyles.completedTaskLeading
                        : TasksTextStyles.uncompletedTaskLeading),
                title: Text(
                  '${tasks[index].title}',
                  style: tasks[index].isCompleted
                      ? TasksTextStyles.completedTitleTextStyle
                      : TasksTextStyles.uncompletedTitleTextStyle,
                ),
                subtitle: Text('${tasks[index].note}',
                    style: tasks[index].isCompleted
                        ? TasksTextStyles.completedNoteStyle
                        : TasksTextStyles.uncompletedNoteStyle),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        '${DateTimeFormat.formatDate(tasks[index].date.day)}/${DateTimeFormat.formatDate(tasks[index].date.month)}/${tasks[index].date.year}',
                        style: tasks[index].isCompleted
                            ? TasksTextStyles.completedDateTimeStyle
                            : TasksTextStyles.uncompletedDateTimeStyle),
                    Text(
                        '${DateTimeFormat.formatTime(tasks[index].time.hour)}:${DateTimeFormat.formatTime(tasks[index].time.minute)}',
                        style: tasks[index].isCompleted
                            ? TasksTextStyles.completedDateTimeStyle
                            : TasksTextStyles.uncompletedDateTimeStyle),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
