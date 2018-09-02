import 'package:flutter/material.dart';
import 'package:gymapp/pages/auth/forgot_details.dart';
import 'package:gymapp/pages/auth/login.dart';
import 'package:gymapp/pages/auth/register.dart';
import 'package:gymapp/pages/home.dart';

class Router {
  static Map appRoutes = <String, WidgetBuilder>{
    "/login": (BuildContext context) => LoginPage(),
    "/home": (BuildContext context) => HomePage(),
    "/register": (BuildContext context) => RegisterPage(),
    "/forget": (BuildContext context) => ForgetDetailsPage()
  };
}
