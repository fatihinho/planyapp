import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  final String _title;
  TodoScreen(this._title);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

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
                'Kişisel Planlar $_title',
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.68,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.white, items: [
        BottomNavigationBarItem(label: 'Bugün', icon: Icon(Icons.today)),
        BottomNavigationBarItem(
            label: 'Hafta', icon: Icon(Icons.calendar_view_day_outlined)),
        BottomNavigationBarItem(
            label: 'Ay', icon: Icon(Icons.calendar_today_rounded)),
      ]),
    );
  }
}
