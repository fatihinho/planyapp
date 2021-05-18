import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  String userName = '';
  List tasks = [];
  List taskFolders = [];
}
