import 'package:flutter/material.dart';
import 'package:planyapp/src/widgets/loginscreen_background_widget.dart';
import 'package:planyapp/src/widgets/loginscreen_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            LoginScreenBackground(),
            LoginScreenWidget(),
          ],
        ));
  }
}
