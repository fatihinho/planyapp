import 'package:flutter/material.dart';

class TaskFolder {
  int id;
  String name;
  Color iconColor;
  bool isPrivate;
  String? password;
  int taskCount;

  TaskFolder(this.id, this.name, this.iconColor, this.isPrivate, this.password,
      this.taskCount);
}
