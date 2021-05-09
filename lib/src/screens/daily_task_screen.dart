import 'package:flutter/material.dart';
import 'package:planyapp/src/models/task_model.dart';

class DailyTaskScreen extends StatefulWidget {
  @override
  _DailyTaskScreenState createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> {
  final Icon _uncompletedTaskLeading =
      Icon(Icons.check_box_outline_blank, size: 36.0);
  final Icon _completedTaskLeading = Icon(
    Icons.check_box_rounded,
    color: Colors.cyan,
    size: 36.0,
  );
  final TextStyle _uncompletedTaskTextStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey[800],
      decoration: TextDecoration.none);
  final TextStyle _completedTaskTextStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
      decoration: TextDecoration.lineThrough);

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

  List<Task> _tasks = [
    Task('Ders çalış', '10.00', false),
    Task('Yürüyüşe çık', '12.00', false),
    Task('Yemek ye', '13.00', false),
    Task('Kitap oku', '15.00', false)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ObjectKey(_tasks[index]),
              background: _stackBehindDismiss(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  _tasks.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text('Deleted $index')));
              },
              child: ListTile(
                leading: GestureDetector(
                    onTap: () {
                      setState(() {
                        _tasks[index].isCompleted = !_tasks[index].isCompleted;
                      });
                    },
                    child: _tasks[index].isCompleted
                        ? _completedTaskLeading
                        : _uncompletedTaskLeading),
                title: Text(
                  '${_tasks[index].title}',
                  style: _tasks[index].isCompleted
                      ? _completedTaskTextStyle
                      : _uncompletedTaskTextStyle,
                ),
                subtitle: Text('${_tasks[index].date}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[400])),
              ),
            );
          }),
    );
  }
}
