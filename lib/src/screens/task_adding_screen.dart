import 'package:flutter/material.dart';

class TaskAddingScreen extends StatefulWidget {
  @override
  _TaskAddingScreenState createState() => _TaskAddingScreenState();
}

class _TaskAddingScreenState extends State<TaskAddingScreen> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
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
      initialTime: TimeOfDay(hour: _time.hour, minute: _time.minute),
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
        print('${_time.hour}:${_time.minute}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

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
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                          decoration: InputDecoration(labelText: 'Başlık')),
                      TextField(decoration: InputDecoration(labelText: 'Not')),
                      SizedBox(height: 24.0),
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
                      SizedBox(height: 24.0),
                      GestureDetector(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Text('Saat Ekle',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                height: screenHeight * 0.75,
              ),
            )
          ],
        ));
  }
}
