import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymapp/blocs/auth_bloc.dart';
import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/localization/app_localization.dart';
import 'package:gymapp/localization/auth_localization.dart';
import 'package:gymapp/pages/auth/forgot_details.dart';
import 'package:gymapp/pages/auth/register.dart';
import 'package:gymapp/pages/home.dart';
import 'package:gymapp/utils/common.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = BlocProvider.of<AuthBloc>(context);

    _navigateTo(Widget page) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider<AuthBloc>(
              bloc: AuthBloc(),
              child: page,
            );
          },
        ),
      );
    }

    _handleLogin() async {
      try {
        var user = await bloc.logIn();
        if (user.uid.isNotEmpty) {
          _navigateTo(HomePage());
        }
      } on PlatformException catch (error) {
        UI.showInSnackBar(_scaffoldKey, error.message);
      }
    }

    _loginButton(AuthBloc bloc) {
      return StreamBuilder(
        stream: bloc.submitLogin,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final Color _activeColor = Theme.of(context).primaryColor;
          final Color _inActiveColor = Theme.of(context).buttonColor;
          return ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 50.0),
              child: FlatButton(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child:
                      Text(AuthLocalization.loginTitle, style: Theme.of(context).textTheme.subhead),
                  color: snapshot.hasData ? _activeColor : _inActiveColor,
                  onPressed: () => snapshot.hasData ? _handleLogin() : null));
        },
      );
    }

    _registerButton(AuthBloc bloc) {
      return StreamBuilder(
        stream: bloc.submitLogin,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final Color _activeColor = Theme.of(context).primaryColor;
          final Color _inActiveColor = Theme.of(context).buttonColor;
          return ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 50.0),
              child: FlatButton(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Text(AuthLocalization.registerTitle,
                      style: Theme.of(context).textTheme.subhead),
                  color: !snapshot.hasData ? _activeColor : _inActiveColor,
                  onPressed: () => !snapshot.hasData ? _navigateTo(RegisterPage()) : null));
        },
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[100],
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        children: <Widget>[
          Text(AppLocalization.appName,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .apply(color: Theme.of(context).primaryColor)
                  .apply(fontSizeDelta: 8.0),
              textAlign: TextAlign.center),
          const SizedBox(height: 30.0),
          InputDetailsSection(bloc),
          Center(
            child: GestureDetector(
                child: Text(
                  AuthLocalization.forgetMyDetails,
                  style: Theme.of(context).textTheme.body2,
                ),
                onTap: () => _navigateTo(ForgetDetailsPage())),
          ),
          const SizedBox(height: 30.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: _loginButton(bloc),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: _registerButton(bloc),
          ),
        ],
      ),
    );
  }
}

class InputDetailsSection extends StatelessWidget {
  final AuthBloc bloc;
  InputDetailsSection(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          emailField(bloc),
          const SizedBox(height: 20.0),
          passwordField(bloc),
          const SizedBox(height: 30.0),
        ],
      ),
    ));
  }

  Widget emailField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return TextField(
          onChanged: bloc.updateEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'example@mail.com',
            labelText: AuthLocalization.emailHint,
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget passwordField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return TextField(
          onChanged: bloc.updatePassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter Password',
            labelText: AuthLocalization.passwordHint,
            errorText: snapshot.error,
          ),
        );
      },
    );
  }
}
