import 'package:flutter/material.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/screens/login_screen.dart';
import 'package:planyapp/src/screens/task_screen.dart';
import 'package:planyapp/src/screens/taskfolder_adding_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String _name;
  HomeScreen(this._name);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _plannedTaskCount = 0;

  var _passwordController = TextEditingController();

  Route _navigateToTasks(int folderId, String title, Color color) {
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

  double _nameFontSize() {
    if (widget._name.length <= 10) {
      return 28.0;
    } else if (widget._name.length > 10 && widget._name.length <= 20) {
      return 24.0;
    } else if (widget._name.length > 20 && widget._name.length <= 30) {
      return 20.0;
    } else if (widget._name.length > 30 && widget._name.length <= 40) {
      return 16.0;
    } else {
      return 12.0;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var taskProvider = Provider.of<TaskProvider>(context);
    var taskFolders = Provider.of<TaskProvider>(context).taskFolders;

    _plannedTaskCount = 0;
    taskFolders.forEach((element) {
      _plannedTaskCount += element.taskCount;
    });

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
                              'Merhaba ${widget._name}!',
                              style: TextStyle(
                                  fontSize: _nameFontSize(),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            _plannedTaskCount > 0
                                ? Text(
                                    'Planlanmış $_plannedTaskCount tane notun var',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    'Planlanmış hiç notun yok',
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
                                    Icon(Icons.warning,
                                        color: Colors.red.shade400),
                                    SizedBox(width: 2.0),
                                    Text('Uyarı'),
                                  ],
                                ),
                                content: Text(
                                  'Bu işlemden sonra tüm veriler silinecektir.\n\nÇıkış yapmak istiyor musun?',
                                  style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontWeight: FontWeight.bold),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.redAccent),
                                    child: Text('İptal'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('Çıkış Yap'),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoginScreen()));
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
                            child: Icon(Icons.logout,
                                color: Colors.white, size: 28.0),
                            alignment: Alignment.topRight),
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Planlar',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.white),
                  child: taskFolders.isNotEmpty
                      ? GridView.builder(
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
                              child: InkWell(
                                onTap: () {
                                  if (!taskFolders[index].isPrivate) {
                                    Navigator.of(context).push(_navigateToTasks(
                                        taskFolders[index].id,
                                        '${taskFolders[index].name}',
                                        taskFolders[index].iconColor));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: Row(
                                                children: [
                                                  Icon(Icons.lock,
                                                      color:
                                                          Colors.red.shade400),
                                                  SizedBox(width: 2.0),
                                                  Text('Şifre'),
                                                ],
                                              ),
                                              content: TextField(
                                                  obscureText: true,
                                                  cursorColor: Colors.redAccent,
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .redAccent)),
                                                  ),
                                                  controller:
                                                      _passwordController),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.redAccent),
                                                  child: Text('İptal'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _passwordController.clear();
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
                                                              .password) {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                _navigateToTasks(
                                                                    taskFolders[
                                                                            index]
                                                                        .id,
                                                                    '${taskFolders[index].name}',
                                                                    taskFolders[
                                                                            index]
                                                                        .iconColor));
                                                        _passwordController
                                                            .clear();
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
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
                                                      ScaffoldMessenger
                                                              .of(context)
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
                                            title: Text(
                                                "Klasör'ü silmek istediğinden emin misin?"),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.redAccent),
                                                child: Text('İptal'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              ElevatedButton(
                                                child: Text('Sil'),
                                                onPressed: () {
                                                  taskProvider
                                                      .deleteTaskFolder(index);
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context)
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
                                        '${taskFolders[index].name}',
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
                                              color:
                                                  taskFolders[index].iconColor,
                                              size: 28.0,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              '${taskFolders[index].taskCount}',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.indigo),
                                            ),
                                          ),
                                          taskFolders[index].isPrivate
                                              ? Center(
                                                  child: Icon(
                                                  Icons.lock,
                                                  color: Colors.red.shade400,
                                                ))
                                              : Center(
                                                  child: Icon(
                                                  Icons.lock_open,
                                                  color: Colors.green.shade400,
                                                ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Icon(
                            Icons.create_new_folder,
                            size: 148.0,
                            color: Colors.cyan.shade200,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ));
  }
}
