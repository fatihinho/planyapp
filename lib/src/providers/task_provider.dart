import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  String userName = '';
  List tasks = [];
  List taskFolders = [];
}
