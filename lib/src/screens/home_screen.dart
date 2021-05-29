import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/screens/task_screen.dart';
import 'package:planyapp/src/screens/taskfolder_adding_screen.dart';
import 'package:planyapp/src/services/firestore_service.dart';
import 'package:planyapp/src/services/notification_service.dart';
import 'package:planyapp/src/utils/colors_util.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _userName = '';

  final _firestoreService = FirestoreService();
  final _notificationService = NotificationService();

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  Route _navigateToTasks(int folderId, String title, String color) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TaskScreen(folderId, title, color),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _navigateToTaskFolderAdding() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TaskFolderAddingScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  double _getNameFontSize() {
    if (_userName.length <= 10) {
      return 28.0;
    } else if (_userName.length > 10 && _userName.length <= 20) {
      return 24.0;
    } else if (_userName.length > 20 && _userName.length <= 30) {
      return 20.0;
    } else if (_userName.length > 30 && _userName.length <= 40) {
      return 16.0;
    } else {
      return 12.0;
    }
  }

  void _initUserName() async {
    var userName = await _firestoreService.getUserName();
    setState(() {
      _userName = 'Merhaba $userName!';
    });
  }

  void _initTotalTaskCount(TaskProvider taskProvider) async {
    var totalTaskCount = await _firestoreService.getTotalTaskCount();
    setState(() {
      taskProvider.totalTaskCount = totalTaskCount;
    });
  }

  void _cancelNotificationsByFolder(DocumentSnapshot taskFolder) async {
    var tasks = await _firestoreService.getTasks();
    List<QueryDocumentSnapshot> tasksByFolder = tasks.docs
        .where((element) => element.get('folderId') == taskFolder.get('id'))
        .toList();
    for (var task in tasksByFolder) {
      await _notificationService
          .cancelNotificationByChannelId(task.get('channelId') ?? -1);
    }
  }

  @override
  void initState() {
    super.initState();
    _initUserName();
    _notificationService.initializeSettings();
    tz.initializeTimeZones();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final taskProvider = Provider.of<TaskProvider>(context);
    _initTotalTaskCount(taskProvider);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.white,
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              Flexible(
                flex: 4,
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(360.0))),
                  ),
                  Container(
                      height: size.height * 0.4,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(360.0),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$_userName',
                              style: TextStyle(
                                  fontSize: _getNameFontSize(),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            taskProvider.totalTaskCount > 0
                                ? Text(
                                    'Kayıtlı ${taskProvider.totalTaskCount} adet notun var',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    'Kayıtlı hiç notun yok',
                                    style: TextStyle(color: Colors.white),
                                  ),
                            SizedBox(height: 48.0),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white),
                                child: Text(
                                  'Yeni Klasör Oluştur',
                                  style: TextStyle(color: Colors.indigo),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(_navigateToTaskFolderAdding());
                                }),
                          ],
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.orange),
                                    SizedBox(width: 4.0),
                                    Text('İsim Düzenle'),
                                  ],
                                ),
                                content: TextField(
                                    controller: _nameController,
                                    cursorColor: Colors.orange,
                                    decoration: InputDecoration(
                                        hintText: 'Yeni İsim',
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.orange)))),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.red),
                                    child: Text(
                                      'İptal',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                      _nameController.clear();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('Düzenle'),
                                    onPressed: () {
                                      if (_nameController.text
                                          .trim()
                                          .isNotEmpty) {
                                        _firestoreService
                                            .editUserName(_nameController.text);
                                        _initUserName();
                                        Navigator.of(context).pop(true);
                                        _nameController.clear();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Colors.orangeAccent,
                                                content:
                                                    Text('İsim Giriniz!')));
                                        _nameController.clear();
                                      }
                                    },
                                  )
                                ],
                              ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.1),
                        child: Align(
                            child: Icon(Icons.edit,
                                color: Colors.white, size: 28.0),
                            alignment: Alignment.topRight),
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Klasörler',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.white),
                  child: FutureBuilder(
                      future: _firestoreService.getTaskFolders(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Icon(Icons.error_outline));
                        } else {
                          final List<DocumentSnapshot> taskFolders =
                              snapshot.data.docs;
                          if (taskFolders.isNotEmpty) {
                            return GridView.builder(
                              padding: const EdgeInsets.all(0.0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.5,
                                crossAxisCount: 2,
                              ),
                              itemCount: taskFolders.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!taskFolders[index]
                                          .get('isPrivate')) {
                                        Navigator.of(context).push(_navigateToTasks(
                                            taskFolders[index].get('id'),
                                            '${taskFolders[index].get('name')}',
                                            taskFolders[index]
                                                .get('iconColor')));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  title: Row(
                                                    children: [
                                                      Icon(Icons.lock,
                                                          color: Colors
                                                              .red.shade400),
                                                      SizedBox(width: 2.0),
                                                      Text('Şifre'),
                                                    ],
                                                  ),
                                                  content: TextField(
                                                      obscureText: true,
                                                      controller:
                                                          _passwordController,
                                                      cursorColor:
                                                          Colors.red.shade400,
                                                      decoration: InputDecoration(
                                                          hintText: 'Şifre',
                                                          filled: true,
                                                          fillColor: Colors
                                                              .grey.shade200,
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          30.0)),
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(Radius.circular(30.0)),
                                                                  borderSide: BorderSide(width: 1.5, color: Colors.red.shade400)))),
                                                  actions: [
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                              primary:
                                                                  Colors.red),
                                                      child: Text('İptal',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        _passwordController
                                                            .clear();
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      child: Text('Onayla'),
                                                      onPressed: () {
                                                        if (_passwordController
                                                            .text.isNotEmpty) {
                                                          if (_passwordController
                                                                  .text ==
                                                              taskFolders[index]
                                                                  .get(
                                                                      'password')) {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(_navigateToTasks(
                                                                    taskFolders[
                                                                            index]
                                                                        .get(
                                                                            'id'),
                                                                    '${taskFolders[index].get('name')}',
                                                                    taskFolders[
                                                                            index]
                                                                        .get(
                                                                            'iconColor')));
                                                            _passwordController
                                                                .clear();
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .redAccent,
                                                                    content: Text(
                                                                        'Geçersiz Şifre!')));
                                                            _passwordController
                                                                .clear();
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .orangeAccent,
                                                                  content: Text(
                                                                      'Şifre Giriniz!')));
                                                        }
                                                      },
                                                    )
                                                  ],
                                                ));
                                      }
                                    },
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .warning_amber_rounded,
                                                        color: Colors.red),
                                                    SizedBox(width: 2.0),
                                                    Text("Uyarı",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                content: Text(
                                                    "Klasör'ü silmek istediğinden emin misin?",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                actions: [
                                                  TextButton(
                                                    child: Text('İptal'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                    child: Text('Sil'),
                                                    onPressed: () {
                                                      _firestoreService
                                                          .deleteTaskFolder(
                                                              taskFolders[index]
                                                                  .id,
                                                              taskFolders[index]
                                                                  .get('id'));
                                                      _cancelNotificationsByFolder(
                                                          taskFolders[index]);
                                                      Navigator.of(context)
                                                          .pop(true);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                          content: Text(
                                                              'Klasör Silindi'),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${taskFolders[index].get('name')}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Center(
                                                child: Icon(
                                                  Icons.folder,
                                                  color: ColorsUtil
                                                      .colorNameToColor(
                                                          taskFolders[index]
                                                              .get(
                                                                  'iconColor')),
                                                  size: 28.0,
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  '${taskFolders[index].get('taskCount')}',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.indigo),
                                                ),
                                              ),
                                              taskFolders[index]
                                                      .get('isPrivate')
                                                  ? Center(
                                                      child: Icon(
                                                      Icons.lock,
                                                      color:
                                                          Colors.red.shade400,
                                                    ))
                                                  : Center(
                                                      child: Icon(
                                                      Icons.lock_open,
                                                      color:
                                                          Colors.green.shade400,
                                                    ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Icon(
                                Icons.create_new_folder,
                                size: 148.0,
                                color: Colors.indigo.shade200,
                              ),
                            );
                          }
                        }
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
