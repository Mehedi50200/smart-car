import 'package:flutter/material.dart';

class Style {
  static const Color primaryColor = Colors.blue;
  static const Color lightColor = Colors.blue;
  static const Color backgroundColor = Color(0xFF1E1E1E);
  static const Color raisedbuttonColor = Color(0xFF444444);

  static const appBarTitleStyle = TextStyle(color: Colors.grey, fontSize: 18);

  static const blueAndGreen = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF0CEBEB),
      Color(0xFF20E3B2),
      Color(0xFF29FFC6),
    ],
  );
  static const orangeAndRed = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFFF416C),
      Color(0xFFFF4B2B),
    ],
  );
  static const orangeAndyellow = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFFFB75E),
      Color(0xFFED8F03),
    ],
  );
  static const transparent = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Colors.transparent,
      Colors.transparent,
    ],
  );
  static Shader textGradient = LinearGradient(
    colors: <Color>[Color(0xff00c9ff), Color(0xff92fe9d)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 80.0));
}
