import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gymapp/blocs/application_bloc.dart';
import 'package:gymapp/blocs/auth_bloc.dart';
import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/blocs/home_bloc.dart';
import 'package:gymapp/localization/app_localization.dart';
import 'package:gymapp/pages/app_start.dart';
import 'package:gymapp/pages/router.dart';

Future<void> main() async {
  return runApp(
    BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider<AuthBloc>(
        bloc: AuthBloc(),
        child: BlocProvider<HomeBloc>(
          bloc: HomeBloc(),
          child: GymApp(),
        ),
      ),
    ),
  );
}

class GymApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Router.appRoutes,
      title: AppLocalization.appName,
      home: AppStart(),
    );
  }
}
