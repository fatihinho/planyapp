import 'package:flutter/material.dart';
import 'package:planyapp/src/screens/month_todo_screen.dart';
import 'package:planyapp/src/screens/today_todo_screen.dart';
import 'package:planyapp/src/screens/week_todo_screen.dart';

class TodoScreen extends StatefulWidget {
  final String _title;
  TodoScreen(this._title);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = [
    TodayTodoScreen(),
    WeekTodoScreen(),
    MonthTodoScreen()
  ];

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
                'Kişisel Planlar ${widget._title}',
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
              color: Colors.white,
              child: _widgetOptions[_selectedIndex],
              height: screenHeight * 0.68,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(label: 'Bugün', icon: Icon(Icons.today)),
          BottomNavigationBarItem(
              label: 'Hafta', icon: Icon(Icons.calendar_view_day_outlined)),
          BottomNavigationBarItem(
              label: 'Ay', icon: Icon(Icons.calendar_today_rounded)),
        ],
      ),
    );
  }
}
