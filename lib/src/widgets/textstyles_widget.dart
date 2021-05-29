import 'package:flutter/material.dart';

class TasksTextStyles {
  static Icon get uncompletedTaskLeading =>
      Icon(Icons.radio_button_off, size: 36.0);
  static Icon get completedTaskLeading => Icon(
        Icons.check_circle,
        color: Colors.cyan.shade800,
        size: 36.0,
      );
  static TextStyle get uncompletedTitleTextStyle => TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange.shade800,
      decoration: TextDecoration.none);
  static TextStyle get completedTitleTextStyle => TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      decoration: TextDecoration.lineThrough);
  static TextStyle get uncompletedNoteStyle => TextStyle(color: Colors.black);
  static TextStyle get completedNoteStyle =>
      TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough);
  static TextStyle get uncompletedActiveDateTimeStyle =>
      TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.shade800);
  static TextStyle get uncompletedPasiveDateTimeStyle =>
      TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800);
  static TextStyle get completedDateTimeStyle => TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      decoration: TextDecoration.lineThrough);
  static Icon get uncompletedActiveAlarmIcon =>
      Icon(Icons.alarm_on, color: Colors.indigo.shade800, size: 20.0);
  static Icon get uncompletedPasiveAlarmIcon =>
      Icon(Icons.alarm_off, color: Colors.deepOrange.shade800, size: 20.0);
  static Icon get completedActiveAlarmIcon =>
      Icon(Icons.alarm_on, color: Colors.grey, size: 20.0);
  static Icon get completedPasiveAlarmIcon =>
      Icon(Icons.alarm_off, color: Colors.grey, size: 20.0);
}
