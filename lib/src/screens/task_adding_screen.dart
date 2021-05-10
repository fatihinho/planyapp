import 'package:flutter/material.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/utils/datetime_format_util.dart';
import 'package:provider/provider.dart';

class TaskAddingScreen extends StatefulWidget {
  @override
  _TaskAddingScreenState createState() => _TaskAddingScreenState();
}

class _TaskAddingScreenState extends State<TaskAddingScreen> {
  var titleController = TextEditingController();
  var noteController = TextEditingController();

  DateTime? _date;
  TimeOfDay? _time;

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        print(_date.toString());
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay? _timePicker = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (_timePicker != null && _timePicker != _time) {
      setState(() {
        _time = _timePicker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    TaskProvider taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.indigo,
        ),
        body: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              color: Colors.indigo,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Yeni Plan',
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                            controller: titleController,
                            decoration: InputDecoration(labelText: 'Başlık')),
                        TextField(
                            controller: noteController,
                            decoration: InputDecoration(labelText: 'Not')),
                        SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Text('Tarih Ekle',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold)),
                            ),
                            _date != null
                                ? Text(
                                    '${DateTimeFormat.formatDate(_date?.day)}/${DateTimeFormat.formatDate(_date?.month)}/${_date?.year}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold))
                                : Text(
                                    '<Tarih Eklenmedi>',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  )
                          ],
                        ),
                        SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _selectTime(context);
                              },
                              child: Text('Saat Ekle',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold)),
                            ),
                            _time != null
                                ? Text(
                                    '${DateTimeFormat.formatTime(_time?.hour)}:${DateTimeFormat.formatTime(_time?.minute)}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold))
                                : Text(
                                    '<Saat Eklenmedi>',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  )
                          ],
                        ),
                        SizedBox(height: 48.0),
                        Container(
                            height: 50.0,
                            width: screenWidth,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (titleController.text.isNotEmpty &&
                                      noteController.text.isNotEmpty &&
                                      _date != null &&
                                      _time != null) {
                                    taskProvider.addTask(titleController.text,
                                        noteController.text, _date!, _time!);
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content:
                                                Text('Eksik Alan Mevcut!')));
                                  }
                                },
                                child: Text('Oluştur')))
                      ],
                    ),
                  ),
                  height: screenHeight * 0.75,
                ),
              ),
            )
          ],
        ));
  }
}
