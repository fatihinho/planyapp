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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.book,
                                color: Colors.red,
                                size: 28.0,
                              ),
                              Text(
                                '10',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Kişisel',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
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
            ),
          ),
        ),
      ],
    ));
  }
}
