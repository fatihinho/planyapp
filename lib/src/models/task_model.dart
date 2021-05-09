import 'package:flutter/material.dart';

class Task {
  String title;
  String note;
  DateTime date;
  TimeOfDay time;
  bool isCompleted;

  Task(this.title, this.note, this.date, this.time, this.isCompleted);
}
