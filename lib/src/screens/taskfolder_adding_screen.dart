import 'package:flutter/material.dart';
import 'package:planyapp/src/services/firestore_service.dart';
import 'package:planyapp/src/utils/colors_util.dart';

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
                              cursorColor: Colors.indigo,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.topic, color: Colors.indigo),
                                  suffixIcon: _folderNameController
                                          .text.isNotEmpty
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _folderNameController.text = '';
                                            });
                                          },
                                          child: Icon(Icons.close,
                                              color: Colors.indigo))
                                      : null,
                                  hintText: 'Klasör Adı',
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
                                          width: 1.5, color: Colors.indigo)))),
                        ),
                        SizedBox(height: 12.0),
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
                                      decoration: BoxDecoration(
                                          color: _isPrivate
                                              ? Colors.grey.shade200
                                              : Colors.green.shade400,
                                          border: Border.all(
                                              color: Colors.black, width: 3.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(90.0))),
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
                                      decoration: BoxDecoration(
                                          color: _isPrivate
                                              ? Colors.red.shade400
                                              : Colors.grey.shade200,
                                          border: Border.all(
                                              color: Colors.black, width: 3.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(90.0))),
                                      height: 50.0,
                                      width: size.width * 0.4,
                                      child: Center(child: Icon(Icons.lock))),
                                ),
                              )
                            ]),
                        SizedBox(height: 12.0),
                        _isPrivate
                            ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextField(
                                    controller: _passwordController,
                                    cursorColor: Colors.red.shade400,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.red.shade400),
                                        suffixIcon: _passwordController
                                                .text.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _passwordController.text =
                                                        '';
                                                  });
                                                },
                                                child: Icon(Icons.close,
                                                    color: Colors.red.shade400))
                                            : null,
                                        hintText: 'Şifre',
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
                                                color: Colors.red.shade400)))),
                              )
                            : Container(),
                        SizedBox(height: 24.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 8.0),
                          child: Container(
                              height: 50.0,
                              width: size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!_isPrivate) {
                                    setState(() {
                                      _passwordController.text = '';
                                    });
                                  }
                                  if (_folderNameController.text.isNotEmpty) {
                                    if (!_isPrivate ||
                                        (_isPrivate &&
                                            _passwordController
                                                .text.isNotEmpty)) {
                                      _firestoreService.addTaskFolder(
                                        UniqueKey().hashCode,
                                        _folderNameController.text,
                                        ColorsUtil.colorValueToName(ColorsUtil
                                            .boxColors[_selectedBoxIndex]
                                            .value),
                                        _isPrivate,
                                        _passwordController.text,
                                        0,
                                      );
                                      Navigator.of(context).pop();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Colors.orangeAccent,
                                              content:
                                                  Text('Eksik Alan Mevcut!')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                Colors.orangeAccent,
                                            content:
                                                Text('Eksik Alan Mevcut!')));
                                  }
                                },
                                child: Text('Oluştur'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.indigo),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                height: size.height * 0.75,
              ),
            )
          ],
        ));
  }
}
