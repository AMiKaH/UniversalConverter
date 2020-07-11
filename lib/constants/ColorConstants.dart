import 'package:flutter/material.dart';

class ColorConstants extends InheritedWidget {
  static ColorConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ColorConstants>();

  const ColorConstants({Widget child, Key key}) : super(key: key, child: child);

  // Buttons
  static final Color actionButton = Color(0xFF145092);
  static final Color buttonBG = Colors.green[500];
  static final Color buttonText = Colors.white;
  static final Color buttonTextDisabled = Colors.grey[700];

  // Text
  static final Color textWhite = Colors.white;

  // Textfields
  static final Color borderActive = Colors.white;
  static final Color borderInactive = Colors.grey[300];

  // Backgrounds
  static final Color bg = Colors.teal;
  static final Color bgDark = Colors.teal[100];
  static final Color bgLight = Colors.teal[600];








  @override
  bool updateShouldNotify(ColorConstants oldWidget) => false;
}