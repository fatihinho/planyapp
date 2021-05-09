import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(String title, String note, DateTime date, TimeOfDay time) {
    tasks.add(Task(title, note, date, time, false));
    notifyListeners();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }
}
