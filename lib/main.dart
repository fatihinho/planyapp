import 'package:flutter/material.dart';
import 'package:planyapp/src/screens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlanyApp',
      home: HomeScreen(),
    );
  }
}
