import 'package:flutter/material.dart';

class LoginScreenInput extends StatelessWidget {
  final double _topRight;
  final double _bottomRight;
  final TextEditingController _nameController;

  LoginScreenInput(this._topRight, this._bottomRight, this._nameController);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(right: 40, bottom: 30),
      child: Container(
        width: size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(_bottomRight),
                  topRight: Radius.circular(_topRight))),
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'İsminiz',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
            ),
          ),
        ),
      ),
    );
  }
}
