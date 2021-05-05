import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    return Scaffold(
        body: Flex(
      direction: Axis.vertical,
      children: [
        Flexible(
          flex: 4,
          child: Container(
            color: Colors.white,
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
                        Text(
                          'Planlanmış 3 tane işin var',
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
                            onPressed: () {}),
                      ],
                    ),
                  )),
            ]),
          ),
        ),
        Flexible(
          flex: 5,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
          ),
        ),
      ],
    ));
  }
}
