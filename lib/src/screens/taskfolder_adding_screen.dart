import 'package:flutter/material.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskFolderAddingScreen extends StatefulWidget {
  @override
  _TaskFolderAddingScreenState createState() => _TaskFolderAddingScreenState();
}

class _TaskFolderAddingScreenState extends State<TaskFolderAddingScreen> {
  var _folderNameController = TextEditingController();

  BoxDecoration _selectedColorBoxDecoration(Color color) {
    return BoxDecoration(
        color: color, border: Border.all(color: Colors.cyanAccent, width: 4.0));
  }

  int _selectedBoxIndex = 0;

  List<Color> _boxColors = [
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.lime,
    Colors.teal,
    Colors.brown
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    TaskProvider taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.indigo,
        ),
        body: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              color: Colors.indigo,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Yeni Klasör',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                            controller: _folderNameController,
                            decoration:
                                InputDecoration(labelText: 'Klasör Adı')),
                        SizedBox(height: 24.0),
                        Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 0;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 0
                                            ? _boxColors[0]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 0
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[0])
                                            : null),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 1;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 1
                                            ? _boxColors[1]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 1
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[1])
                                            : null),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 2;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 2
                                            ? _boxColors[2]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 2
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[2])
                                            : null),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 3;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 3
                                            ? _boxColors[3]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 3
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[3])
                                            : null),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 4;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 4
                                            ? _boxColors[4]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 4
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[4])
                                            : null),
                                  ),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 5;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 5
                                            ? _boxColors[5]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 5
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[5])
                                            : null),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 6;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 6
                                            ? _boxColors[6]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 6
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[6])
                                            : null),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 7;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 7
                                            ? _boxColors[7]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 7
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[7])
                                            : null),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 8;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 8
                                            ? _boxColors[8]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 8
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[8])
                                            : null),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBoxIndex = 9;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        color: _selectedBoxIndex != 9
                                            ? _boxColors[9]
                                            : null,
                                        height: 30.0,
                                        width: screenWidth * 0.15,
                                        decoration: _selectedBoxIndex == 9
                                            ? _selectedColorBoxDecoration(
                                                _boxColors[9])
                                            : null),
                                  ),
                                ),
                              ])
                        ]),
                        SizedBox(height: 48.0),
                        Container(
                            height: 50.0,
                            width: screenWidth,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_folderNameController.text.isNotEmpty) {
                                  taskProvider.addTaskFolder(
                                      _folderNameController.text,
                                      _boxColors[_selectedBoxIndex],
                                      0);
                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.redAccent,
                                          content: Text('Eksik Alan Mevcut!')));
                                }
                              },
                              child: Text('Oluştur'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.cyan),
                            ))
                      ],
                    ),
                  ),
                  height: screenHeight * 0.75,
                ),
              ),
            )
          ],
        ));
  }
}
