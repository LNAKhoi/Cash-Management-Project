import 'package:flutter/material.dart';

class ScreenNavigator {
  static Future navigateTo(
      BuildContext context, Widget destinationWidget) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => destinationWidget));
  }
}
