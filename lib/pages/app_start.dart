import 'package:flutter/material.dart';
import 'package:gymapp/blocs/application_bloc.dart';
import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/pages/auth/login.dart';
import 'package:gymapp/pages/home.dart';

class AppStart extends StatefulWidget {
  @override
  AppStartState createState() => AppStartState();
}

enum DestinationStatus {
  notSignedIn,
  signedIn,
}

class AppStartState extends State<AppStart> {
  DestinationStatus destinationStatus;

  @override
  Widget build(BuildContext context) {
    getDestinationView();
    switch (destinationStatus) {
      case DestinationStatus.notSignedIn:
        return LoginPage();
        break;
      case DestinationStatus.signedIn:
        return HomePage();
        break;
      default:
        return Container();
        break;
    }
  }

  void getDestinationView() async {
    try {
      var state = await BlocProvider.of<ApplicationBloc>(context).isUserLogged();
      setState(() {
        destinationStatus = state ? DestinationStatus.signedIn : DestinationStatus.notSignedIn;
      });
    } on Exception catch (error) {
      print('Exception ====> $error');
    }
  }
}
