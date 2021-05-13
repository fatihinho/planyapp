import 'package:flutter/material.dart';
import 'package:planyapp/src/models/task_model.dart';
import 'package:planyapp/src/models/taskfolder_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  List<TaskFolder> taskFolders = [];

  void addTask(String title, String note, DateTime? date, TimeOfDay? time,
      bool isCompleted, int folderId) {
    tasks.add(Task(title, note, date, time, isCompleted, folderId));
    taskFolders.firstWhere((element) => element.id == folderId).taskCount++;
    notifyListeners();
  }

  void deleteTask(int index, int folderId) {
    tasks.removeAt(index);
    taskFolders.firstWhere((element) => element.id == folderId).taskCount--;
    notifyListeners();
  }

  void addTaskFolder(int id, String name, Color iconColor, bool isPrivate,
      String? password, int taskCount) {
    taskFolders
        .add(TaskFolder(id, name, iconColor, isPrivate, password, taskCount));
    notifyListeners();
  }

  void deleteTaskFolder(int index) {
    taskFolders.removeAt(index);
    notifyListeners();
  }
}
