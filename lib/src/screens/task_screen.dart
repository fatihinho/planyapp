import 'package:flutter/material.dart';
import 'package:planyapp/src/screens/monthly_task_screen.dart';
import 'package:planyapp/src/screens/daily_task_screen.dart';
import 'package:planyapp/src/screens/task_adding_screen.dart';
import 'package:planyapp/src/screens/weekly_task_screen.dart';

class TaskScreen extends StatefulWidget {
  final String _title;
  TaskScreen(this._title);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Route _navigateToTaskAdding() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TaskAddingScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
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

  final List<Widget> _widgetOptions = [
    DailyTaskScreen(),
    WeeklyTaskScreen(),
    MonthlyTaskScreen()
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
        onPressed: () {
          Navigator.of(context).push(_navigateToTaskAdding());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(label: 'Günlük', icon: Icon(Icons.today)),
          BottomNavigationBarItem(
              label: 'Haftalık', icon: Icon(Icons.calendar_view_day_outlined)),
          BottomNavigationBarItem(
              label: 'Aylık', icon: Icon(Icons.calendar_today_rounded)),
        ],
      ),
    );
  }
}
