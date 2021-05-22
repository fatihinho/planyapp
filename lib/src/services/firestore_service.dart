import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planyapp/src/services/auth_service.dart';

class FirestoreService {
  final _authService = AuthService();

  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> setUserName(String userName) async {
    await _users
        .doc(_authService.userUID)
        .set({'userName': userName}).catchError((e) => throw e.toString());
  }

  Future<String> getUserName() async {
    var user = await _users
        .doc(_authService.userUID)
        .get()
        .catchError((e) => throw e.toString());
    return user.get('userName') as String;
  }

  Future<void> editUserName(String userName) async {
    await _users
        .doc(_authService.userUID)
        .update({'userName': userName}).catchError((e) => throw e.toString());
  }

  Stream<QuerySnapshot> getTasks() {
    return _users.doc(_authService.userUID).collection('task').snapshots();
  }

  Future<DocumentSnapshot> getTaskById(String id) async {
    return await _users
        .doc(_authService.userUID)
        .collection('task')
        .doc(id)
        .get();
  }

  Stream<QuerySnapshot> getTaskFolders() {
    return _users
        .doc(_authService.userUID)
        .collection('taskFolder')
        .snapshots();
  }

  Future<int> getCurrentTaskCount(int folderId) async {
    var taskFolder = await _users
        .doc(_authService.userUID)
        .collection('taskFolder')
        .get()
        .then((value) =>
            value.docs.firstWhere((element) => element['id'] == folderId))
        .catchError((e) => throw e.toString());
    var currentTaskCount = await _users
        .doc(_authService.userUID)
        .collection('taskFolder')
        .doc(taskFolder.id)
        .get()
        .catchError((e) => throw e.toString());
    return currentTaskCount.get('taskCount') as int;
  }

  Future<void> addTask(
      int id,
      String? title,
      String? note,
      String? day,
      String? month,
      String? year,
      String? hour,
      String? minute,
      bool isCompleted,
      int folderId) async {
    var taskFolder = await _users
        .doc(_authService.userUID)
        .collection('taskFolder')
        .get()
        .then((value) =>
            value.docs.firstWhere((element) => element['id'] == folderId));
    var currentTaskCount = await getCurrentTaskCount(folderId);
    await _users
        .doc(_authService.userUID)
        .collection('task')
        .add({
          'id': id,
          'title': title,
          'note': note,
          'day': day,
          'month': month,
          'year': year,
          'hour': hour,
          'minute': minute,
          'isCompleted': isCompleted,
          'folderId': folderId
        })
        .then((_) => _users
            .doc(_authService.userUID)
            .collection('taskFolder')
            .doc(taskFolder.id)
            .update({'taskCount': ++currentTaskCount}))
        .catchError((e) => throw e.toString());
  }

  Future<void> addTaskFolder(int id, String name, String iconColor,
      bool isPrivate, String? password, int taskCount) async {
    await _users.doc(_authService.userUID).collection('taskFolder').add({
      'id': id,
      'name': name,
      'iconColor': iconColor,
      'isPrivate': isPrivate,
      'password': password,
      'taskCount': taskCount
    }).catchError((e) => throw e.toString());
  }

  Future<void> editTask(String id, String? title, String? note, String? day,
      String? month, String? year, String? hour, String? minute) async {
    await _users.doc(_authService.userUID).collection('task').doc(id).update({
      'title': title,
      'note': note,
      'day': day,
      'month': month,
      'year': year,
      'hour': hour,
      'minute': minute,
    }).catchError((e) => throw e.toString());
  }

  Future<void> deleteTask(String id, int folderId) async {
    var taskFolder = await _users
        .doc(_authService.userUID)
        .collection('taskFolder')
        .get()
        .then((value) =>
            value.docs.firstWhere((element) => element['id'] == folderId));
    var currentTaskCount = await getCurrentTaskCount(folderId);
    await _users
        .doc(_authService.userUID)
        .collection('task')
        .doc(id)
        .delete()
        .then((value) => _users
            .doc(_authService.userUID)
            .collection('taskFolder')
            .doc(taskFolder.id)
            .update({'taskCount': --currentTaskCount}))
        .catchError((e) => e.toString());
  }

  Future<void> deleteTaskFolder(String id, int folderId) async {
    var tasks = await _users.doc(_authService.userUID).collection('task').get();
    List<QueryDocumentSnapshot> tasksByFolder = tasks.docs
        .where((element) => element.get('folderId') == folderId)
        .toList();
    for (var task in tasksByFolder) {
      await _users
          .doc(_authService.userUID)
          .collection('task')
          .doc(task.id)
          .delete()
          .catchError((e) => e.toString());
    }
    await _users
        .doc(_authService.userUID)
        .collection('taskFolder')
        .doc(id)
        .delete()
        .catchError((e) => throw e.toString());
  }

  Future<bool> isTaskCompleted(String id) async {
    var task = await _users
        .doc(_authService.userUID)
        .collection('task')
        .doc(id)
        .get()
        .catchError((e) => throw e.toString());
    return task.get('isCompleted');
  }

  Future<void> updateTaskCompleted(String id) async {
    var isCompleted = await isTaskCompleted(id);
    await _users.doc(_authService.userUID).collection('task').doc(id).update(
        {'isCompleted': !isCompleted}).catchError((e) => throw e.toString());
  }

  Future<int> getTotalTaskCount() async {
    var tasks = await _users.doc(_authService.userUID).collection('task').get();
    return tasks.docs.length;
  }
}
