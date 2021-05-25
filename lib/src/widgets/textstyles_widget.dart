import 'package:flutter/material.dart';

class TasksTextStyles {
  static Icon get uncompletedTaskLeading =>
      Icon(Icons.radio_button_off, size: 36.0);
  static Icon get completedTaskLeading => Icon(
        Icons.check_circle,
        color: Colors.indigo,
        size: 36.0,
      );
  static TextStyle get uncompletedTitleTextStyle => TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.indigo,
      decoration: TextDecoration.none);
  static TextStyle get completedTitleTextStyle => TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      decoration: TextDecoration.lineThrough);
  static TextStyle get uncompletedNoteStyle => TextStyle(color: Colors.black);
  static TextStyle get completedNoteStyle =>
      TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough);
  static TextStyle get uncompletedDateTimeStyle =>
      TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo);
  static TextStyle get completedDateTimeStyle => TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      decoration: TextDecoration.lineThrough);
  static Icon get uncompletedAlarmIcon =>
      Icon(Icons.alarm, color: Colors.indigo, size: 20.0);
  static Icon get completedAlarmIcon =>
      Icon(Icons.alarm, color: Colors.grey, size: 20.0);
}
