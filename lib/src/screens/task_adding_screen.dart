import 'package:flutter/material.dart';
import 'package:planyapp/src/services/firestore_service.dart';
import 'package:planyapp/src/utils/datetime_format_util.dart';

class TaskAddingScreen extends StatefulWidget {
  final int _folderId;
  TaskAddingScreen(this._folderId);

  @override
  _TaskAddingScreenState createState() => _TaskAddingScreenState();
}

class _TaskAddingScreenState extends State<TaskAddingScreen> {
  var _titleController = TextEditingController();
  var _noteController = TextEditingController();

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
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.cyan,
        ),
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.cyan,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: Colors.white,
                        size: 36.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Yeni Plan',
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                            controller: _titleController,
                            decoration: InputDecoration(labelText: 'Başlık')),
                        TextField(
                            controller: _noteController,
                            decoration: InputDecoration(labelText: 'Not')),
                        SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                                SizedBox(width: 4.0),
                                _date != null
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _date = null;
                                          });
                                        },
                                        child: Text('(Sıfırla)',
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.bold)),
                                      )
                                    : Container()
                              ],
                            ),
                            _date != null
                                ? Text(
                                    '${DateTimeFormat.formatDate(_date?.day.toString())}/${DateTimeFormat.formatDate(_date?.month.toString())}/${_date?.year}',
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
                            Row(
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
                                SizedBox(width: 4.0),
                                _time != null
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _time = null;
                                          });
                                        },
                                        child: Text('(Sıfırla)',
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.bold)),
                                      )
                                    : Container()
                              ],
                            ),
                            _time != null
                                ? Text(
                                    '${DateTimeFormat.formatTime(_time?.hour.toString())}:${DateTimeFormat.formatTime(_time?.minute.toString())}',
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
                            width: size.width,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_titleController.text.isNotEmpty &&
                                      _noteController.text.isNotEmpty) {
                                    addTask(
                                        UniqueKey().hashCode,
                                        _titleController.text,
                                        _noteController.text,
                                        _date?.day.toString(),
                                        _date?.month.toString(),
                                        _date?.year.toString(),
                                        _time?.hour.toString(),
                                        _time?.minute.toString(),
                                        false,
                                        widget._folderId);
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                Colors.orangeAccent,
                                            content:
                                                Text('Eksik Alan Mevcut!')));
                                  }
                                },
                                child: Text('Oluştur'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.indigo)))
                      ],
                    ),
                  ),
                  height: size.height * 0.75,
                ),
              ),
            )
          ],
        ));
  }
}
