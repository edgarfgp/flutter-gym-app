import 'package:flutter/material.dart';

class UI {
  static void showInSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String value) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }
}
