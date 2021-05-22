import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  num totalTaskCount = 0;

  void increaseTotalTaskCount() {
    totalTaskCount++;
    notifyListeners();
  }

  void decreaseTotalTaskCount() {
    totalTaskCount--;
    notifyListeners();
  }
}
