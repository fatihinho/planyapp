import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planyapp/src/models/task_model.dart';
import 'package:planyapp/src/models/taskfolder_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  List<TaskFolder> taskFolders = [];

  void addTask(String title, String note, DateTime date, TimeOfDay time) {
    tasks.add(Task(title, note, date, time, false));
    notifyListeners();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }

  void addTaskFolder(String folderName, Color iconColor, int taskNumber) {
    taskFolders.add(TaskFolder(folderName, iconColor, taskNumber));
    notifyListeners();
  }

  void deleteTaskFolder(int index) {
    taskFolders.removeAt(index);
    notifyListeners();
  }
}
