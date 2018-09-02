import 'package:flutter/material.dart';
import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/blocs/home_bloc.dart';
import 'package:gymapp/localization/app_localization.dart';
import 'package:gymapp/pages/nav_hub.dart';

class HomePage extends StatefulWidget {
  @override
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<HomeBloc>(context).getUserData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalization.dashBoardTitle),
          centerTitle: true,
        ),
        drawer: NavHubDrawer(user),
        body: Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
