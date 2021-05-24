import 'package:flutter/material.dart';
import 'package:planyapp/src/services/firestore_service.dart';
import 'package:planyapp/src/utils/colors_util.dart';
import 'package:planyapp/src/widgets/admob_banner_widget.dart';

class TaskFolderAddingScreen extends StatefulWidget {
  @override
  _TaskFolderAddingScreenState createState() => _TaskFolderAddingScreenState();
}

class _TaskFolderAddingScreenState extends State<TaskFolderAddingScreen> {
  var _isPrivate = false;
  var _selectedBoxIndex = 0;

  final _firestoreService = FirestoreService();

  final _passwordController = TextEditingController();
  final _folderNameController = TextEditingController();

  BoxDecoration _selectedColorBoxDecoration(Color color) {
    return BoxDecoration(
        color: color, border: Border.all(color: Colors.cyanAccent, width: 4.0));
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _folderNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.indigo,
        ),
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.indigo,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.create_new_folder,
                        color: Colors.white,
                        size: 36.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Yeni Klasör',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                              controller: _folderNameController,
                              decoration:
                                  InputDecoration(labelText: 'Klasör Adı')),
                        ),
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
                                            ? ColorsUtil.boxColors[0]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 0
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[0])
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
                                            ? ColorsUtil.boxColors[1]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 1
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[1])
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
                                            ? ColorsUtil.boxColors[2]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 2
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[2])
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
                                            ? ColorsUtil.boxColors[3]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 3
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[3])
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
                                            ? ColorsUtil.boxColors[4]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 4
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[4])
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
                                            ? ColorsUtil.boxColors[5]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 5
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[5])
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
                                            ? ColorsUtil.boxColors[6]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 6
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[6])
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
                                            ? ColorsUtil.boxColors[7]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 7
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[7])
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
                                            ? ColorsUtil.boxColors[8]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 8
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[8])
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
                                            ? ColorsUtil.boxColors[9]
                                            : null,
                                        height: 30.0,
                                        width: size.width * 0.15,
                                        decoration: _selectedBoxIndex == 9
                                            ? _selectedColorBoxDecoration(
                                                ColorsUtil.boxColors[9])
                                            : null),
                                  ),
                                ),
                              ])
                        ]),
                        SizedBox(height: 24.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPrivate = false;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      color: _isPrivate
                                          ? Colors.grey.shade200
                                          : Colors.green.shade400,
                                      height: 50.0,
                                      width: size.width * 0.4,
                                      child:
                                          Center(child: Icon(Icons.lock_open))),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPrivate = true;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      color: _isPrivate
                                          ? Colors.red.shade400
                                          : Colors.grey.shade200,
                                      height: 50.0,
                                      width: size.width * 0.4,
                                      child: Center(child: Icon(Icons.lock))),
                                ),
                              )
                            ]),
                        _isPrivate
                            ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextField(
                                    obscureText: true,
                                    controller: _passwordController,
                                    decoration:
                                        InputDecoration(labelText: 'Şifre')),
                              )
                            : Container(),
                        SizedBox(height: 48.0),
                        Container(
                            height: 50.0,
                            width: size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_folderNameController.text.isNotEmpty) {
                                  if (!_isPrivate ||
                                      (_isPrivate &&
                                          _passwordController
                                              .text.isNotEmpty)) {
                                    _firestoreService.addTaskFolder(
                                      UniqueKey().hashCode,
                                      _folderNameController.text,
                                      ColorsUtil.colorValueToName(ColorsUtil
                                          .boxColors[_selectedBoxIndex].value),
                                      _isPrivate,
                                      _passwordController.text,
                                      0,
                                    );
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                Colors.orangeAccent,
                                            content:
                                                Text('Eksik Alan Mevcut!')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.orangeAccent,
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
                ),
                height: size.height * 0.70,
              ),
            )
          ],
        ),
        bottomNavigationBar: AdMobBanner());
  }
}
