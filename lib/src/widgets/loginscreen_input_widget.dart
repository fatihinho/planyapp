import 'package:flutter/material.dart';

class LoginScreenInput extends StatelessWidget {
  final double topRight;
  final double bottomRight;
  final TextEditingController _nameController;

  LoginScreenInput(this.topRight, this.bottomRight, this._nameController);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(right: 40, bottom: 30),
      child: Container(
        width: size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(bottomRight),
                  topRight: Radius.circular(topRight))),
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
