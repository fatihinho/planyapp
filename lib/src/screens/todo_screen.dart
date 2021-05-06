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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyan,
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.indigo,
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Container(
              height: screenHeight * 0.12,
              width: screenWidth,
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
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0))),
            )
          ],
        ));
  }
}
