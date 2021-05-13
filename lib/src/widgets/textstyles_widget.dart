import 'package:flutter/material.dart';

class TasksTextStyles {
  static Icon get uncompletedTaskLeading =>
      Icon(Icons.radio_button_off, size: 36.0);
  static Icon get completedTaskLeading => Icon(
        Icons.check_circle,
        color: Colors.cyan,
        size: 36.0,
      );
  static TextStyle get uncompletedTitleTextStyle => TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey[800],
      decoration: TextDecoration.none);
  static TextStyle get completedTitleTextStyle => TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
      decoration: TextDecoration.lineThrough);
  static TextStyle get uncompletedNoteStyle =>
      TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey[400]);
  static TextStyle get completedNoteStyle => TextStyle(
      fontWeight: FontWeight.normal,
      color: Colors.grey,
      decoration: TextDecoration.lineThrough);
  static TextStyle get uncompletedDateTimeStyle =>
      TextStyle(fontWeight: FontWeight.bold, color: Colors.brown);
  static TextStyle get completedDateTimeStyle => TextStyle(
      fontWeight: FontWeight.normal,
      color: Colors.grey,
      decoration: TextDecoration.lineThrough);
}
