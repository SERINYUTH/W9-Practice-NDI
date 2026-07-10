import 'package:flutter/material.dart';

class AppTheme {
  static Color textColor = const Color(0xFF141312);
  static Color backgroundColor = const Color(0xFFFFFAF0);

  static Color yellowColor = const Color(0xFFF8C44F);
  static Color greenColor = const Color(0xFF40A955);
  static Color redColor = const Color(0xFF9D5551);

  static TextStyle paragraph = TextStyle(color: textColor, fontSize: 15);
  static TextStyle heading = paragraph.copyWith(fontSize: 30);
}
