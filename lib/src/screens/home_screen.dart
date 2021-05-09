import 'package:flutter/material.dart';
import 'package:planyapp/src/screens/task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    Route _navigateToTasks(String title) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            TaskScreen(title),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, -1.0);
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
              child: GridView.builder(
                padding: const EdgeInsets.all(0.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.5,
                  crossAxisCount: 2,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(_navigateToTasks(index.toString()));
                      },
                      onLongPress: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$index. plan'),
                          ),
                        );
                      },
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
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
