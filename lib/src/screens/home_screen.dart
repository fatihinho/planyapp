import 'package:flutter/material.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/screens/task_screen.dart';
import 'package:planyapp/src/screens/taskfolder_adding_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _plannedTaskCount = 0;

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    var taskProvider = Provider.of<TaskProvider>(context);
    var taskFolders = Provider.of<TaskProvider>(context).taskFolders;

    _plannedTaskCount = 0;
    taskFolders.forEach((element) {
      _plannedTaskCount += element.taskCount;
    });

    return Scaffold(
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
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(360))),
              ),
              Container(
                  height: screenHeight * 0.40,
                  width: screenWidth * 0.80,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(360),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Merhaba Fatih!',
                          style: TextStyle(
                              fontSize: 32.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        _plannedTaskCount > 0
                            ? Text(
                                'Planlanan $_plannedTaskCount tane işin var',
                                style: TextStyle(color: Colors.white),
                              )
                            : Text(
                                'Planlanan hiç işin yok',
                                style: TextStyle(color: Colors.white),
                              ),
                        SizedBox(height: 48.0),
                        ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.white),
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
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Planlar',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          ),
          Flexible(
            flex: 5,
            child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
              child: taskFolders.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.all(0.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.5,
                        crossAxisCount: 2,
                      ),
                      itemCount: taskFolders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(_navigateToTasks(
                                  taskFolders[index].id,
                                  '${taskFolders[index].name}',
                                  taskFolders[index].iconColor));
                            },
                            onLongPress: () {
                              taskProvider.deleteTaskFolder(index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text('Klasör Silindi'),
                                ),
                              );
                            },
                            onDoubleTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Id: ${taskFolders[index].id}'),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.folder,
                                        color: taskFolders[index].iconColor,
                                        size: 28.0,
                                      ),
                                      Text(
                                        '${taskFolders[index].taskCount}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        '${taskFolders[index].name}',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('')
                                    ],
                                  )
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
                        color: Colors.cyan[200],
                      ),
                    ),
            ),
          ),
        ],
      ),
    ));
  }
}
