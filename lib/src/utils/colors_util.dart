import 'package:flutter/material.dart';

class ColorsUtil {
  static List<Color> boxColors = [
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.lime,
    Colors.teal,
    Colors.brown
  ];

  static String colorValueToName(int value) {
    if (value == boxColors[0].value) {
      return 'blue';
    } else if (value == boxColors[1].value) {
      return 'yellow';
    } else if (value == boxColors[2].value) {
      return 'green';
    } else if (value == boxColors[3].value) {
      return 'red';
    } else if (value == boxColors[4].value) {
      return 'orange';
    } else if (value == boxColors[5].value) {
      return 'purple';
    } else if (value == boxColors[6].value) {
      return 'pink';
    } else if (value == boxColors[7].value) {
      return 'lime';
    } else if (value == boxColors[8].value) {
      return 'teal';
    } else if (value == boxColors[9].value) {
      return 'brown';
    } else {
      return '';
    }
  }

  static Color colorNameToColor(String colorName) {
    if (colorName == 'blue') {
      return Colors.blue;
    } else if (colorName == 'yellow') {
      return Colors.yellow;
    } else if (colorName == 'green') {
      return Colors.green;
    } else if (colorName == 'red') {
      return Colors.red;
    } else if (colorName == 'orange') {
      return Colors.orange;
    } else if (colorName == 'purple') {
      return Colors.purple;
    } else if (colorName == 'pink') {
      return Colors.pink;
    } else if (colorName == 'lime') {
      return Colors.lime;
    } else if (colorName == 'teal') {
      return Colors.teal;
    } else if (colorName == 'brown') {
      return Colors.brown;
    } else {
      return Colors.transparent;
    }
  }
}
