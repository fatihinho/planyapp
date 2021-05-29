import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planyapp/src/services/firestore_service.dart';
import 'package:planyapp/src/services/notification_service.dart';
import 'package:planyapp/src/utils/datetime_format_util.dart';
import 'package:timezone/data/latest.dart' as tz;

class TaskEditingScreen extends StatefulWidget {
  final String _id;
  final bool hasAlarm;
  final Function _editTask;
  TaskEditingScreen(this._id, this.hasAlarm, this._editTask);

  @override
  _TaskEditingScreenState createState() => _TaskEditingScreenState();
}

class _TaskEditingScreenState extends State<TaskEditingScreen> {
  late bool _hasAlarm;
  late DocumentSnapshot _task;

  final _firestoreService = FirestoreService();
  final _notificationService = NotificationService();

  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime? _date;
  TimeOfDay? _time;

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
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

  void _initTask() async {
    var task = await _firestoreService.getTaskById(widget._id);
    setState(() {
      _task = task;
    });
  }

  void _initTaskFields() async {
    var task = await _firestoreService.getTaskById(widget._id);
    setState(() {
      if (task.get('title') != null) {
        _titleController.text = task.get('title');
      }
      if (task.get('note') != null) {
        _noteController.text = task.get('note');
      }
      if (task.get('year') != null) {
        _date = DateTime(int.parse(task.get('year')),
            int.parse(task.get('month')), int.parse(task.get('day')));
      }
      if (task.get('hour') != null) {
        _time = TimeOfDay(
            hour: int.parse(task.get('hour')),
            minute: int.parse(task.get('minute')));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationService.initializeSettings();
    tz.initializeTimeZones();
    _initTask();
    _initTaskFields();
    _hasAlarm = widget.hasAlarm;
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
          backgroundColor: Colors.orange,
        ),
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.orange,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 36.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Not Düzenle',
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
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            TextField(
                                controller: _titleController,
                                cursorColor: Colors.orange,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.topic, color: Colors.orange),
                                    suffixIcon: _titleController.text.isNotEmpty
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _titleController.text = '';
                                              });
                                            },
                                            child: Icon(Icons.close,
                                                color: Colors.orange))
                                        : null,
                                    hintText: 'Başlık',
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: Colors.orange)))),
                            SizedBox(height: 16.0),
                            TextField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                controller: _noteController,
                                cursorColor: Colors.orange,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.notes, color: Colors.orange),
                                    suffixIcon: _noteController.text.isNotEmpty
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _noteController.text = '';
                                              });
                                            },
                                            child: Icon(Icons.close,
                                                color: Colors.orange))
                                        : null,
                                    hintText: 'Not',
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: Colors.orange)))),
                          ]),
                        ),
                        SizedBox(height: 12.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _hasAlarm = false;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: _hasAlarm
                                              ? Colors.grey.shade200
                                              : Colors.red.shade400,
                                          border: Border.all(
                                              color: Colors.black, width: 3.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(90.0))),
                                      height: 50.0,
                                      width: size.width * 0.4,
                                      child:
                                          Center(child: Icon(Icons.alarm_off))),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _hasAlarm = true;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: _hasAlarm
                                              ? Colors.cyan.shade400
                                              : Colors.grey.shade200,
                                          border: Border.all(
                                              color: Colors.black, width: 3.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(90.0))),
                                      height: 50.0,
                                      width: size.width * 0.4,
                                      child:
                                          Center(child: Icon(Icons.alarm_on))),
                                ),
                              )
                            ]),
                        SizedBox(height: 12.0),
                        _hasAlarm
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: Card(
                                        elevation: 5.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.date_range,
                                                        color: Colors
                                                            .indigo.shade800),
                                                    SizedBox(width: 2.0),
                                                    Text('Tarih Ekle',
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            color: Colors.indigo
                                                                .shade800,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                _date != null
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                              '${DateTimeFormat.formatDate(_date?.day.toString())}/${DateTimeFormat.formatDate(_date?.month.toString())}/${_date?.year}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.0,
                                                                  color: Colors
                                                                      .indigo
                                                                      .shade800,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(width: 2.0),
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _date = null;
                                                                });
                                                              },
                                                              child: Icon(
                                                                  Icons.clear,
                                                                  color: Colors
                                                                      .red
                                                                      .shade400))
                                                        ],
                                                      )
                                                    : Text(
                                                        'Tarih Eklenmedi',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    GestureDetector(
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                      child: Card(
                                        elevation: 5.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.alarm,
                                                            color: Colors.indigo
                                                                .shade800),
                                                        SizedBox(width: 2.0),
                                                        Text('Saat Ekle',
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .indigo
                                                                    .shade800,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                _time != null
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                              '${DateTimeFormat.formatTime(_time?.hour.toString())}:${DateTimeFormat.formatTime(_time?.minute.toString())}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.0,
                                                                  color: Colors
                                                                      .indigo
                                                                      .shade800,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(width: 2.0),
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _time = null;
                                                                });
                                                              },
                                                              child: Icon(
                                                                  Icons.clear,
                                                                  color: Colors
                                                                      .red
                                                                      .shade400))
                                                        ],
                                                      )
                                                    : Text(
                                                        'Saat Eklenmedi',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(height: 24.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 8.0),
                          child: Container(
                              height: 50.0,
                              width: size.width,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (!_hasAlarm) {
                                      setState(() {
                                        _date = null;
                                        _time = null;
                                      });
                                    }
                                    if (_task.get('channelId') != null) {
                                      int channelId = _task.get('channelId');
                                      _notificationService
                                          .cancelNotificationByChannelId(
                                              channelId);
                                    }
                                    int? channelId;
                                    if (_hasAlarm &&
                                        _date != null &&
                                        _time != null &&
                                        DateTime.now().hour <= _time!.hour &&
                                        DateTime.now().minute < _time!.minute &&
                                        (_titleController.text
                                                .trim()
                                                .isNotEmpty ||
                                            _noteController.text
                                                .trim()
                                                .isNotEmpty)) {
                                      channelId = UniqueKey().hashCode;
                                      DateTime dateTime = DateTime(
                                          _date!.year,
                                          _date!.month,
                                          _date!.day,
                                          _time!.hour,
                                          _time!.minute);
                                      _notificationService.showNotification(
                                          dateTime, channelId);
                                    }
                                    widget._editTask(
                                        widget._id,
                                        _titleController,
                                        _noteController,
                                        _date,
                                        _time,
                                        _hasAlarm,
                                        channelId);
                                  },
                                  child: Text('Düzenle'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.orange))),
                        )
                      ],
                    ),
                  ),
                ),
                height: size.height * 0.75,
              ),
            )
          ],
        ));
  }
}
