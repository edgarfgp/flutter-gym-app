import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymapp/blocs/auth_bloc.dart';
import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/localization/auth_localization.dart';
import 'package:gymapp/utils/common.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = BlocProvider.of<AuthBloc>(context);
    _handleRegister() async {
      try {
        await bloc.resgister();
        Navigator.pushNamed(context, "/login");
      } on PlatformException catch (error) {
        UI.showInSnackBar(_scaffoldKey, error.message);
      }
    }

    _registerButton(AuthBloc bloc) {
      return StreamBuilder(
          stream: bloc.submitRegister,
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
                    color: snapshot.hasData ? _activeColor : _inActiveColor,
                    onPressed: () => snapshot.hasData ? _handleRegister() : null));
          });
    }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(AuthLocalization.registerTitle),
        ),
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey[100],
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
          children: <Widget>[
            Text(AuthLocalization.registerTitle,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .apply(color: Theme.of(context).primaryColor)
                    .apply(fontSizeDelta: 8.0),
                textAlign: TextAlign.center),
            const SizedBox(height: 30.0),
            InputDetailsSection(bloc),
            const SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: _registerButton(bloc),
            ),
          ],
        ),
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
          nameField(bloc),
          const SizedBox(height: 20.0),
          lastNameField(bloc),
          const SizedBox(height: 20.0),
          emailField(bloc),
          const SizedBox(height: 20.0),
          passwordField(bloc),
          const SizedBox(height: 30.0),
        ],
      ),
    ));
  }

  Widget nameField(AuthBloc blocState) {
    return StreamBuilder(
      stream: blocState.nameStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return TextField(
          onChanged: blocState.updateName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'John',
            labelText: AuthLocalization.nameHint,
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget lastNameField(AuthBloc blocState) {
    return StreamBuilder(
      stream: blocState.lastNameStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return TextField(
          onChanged: blocState.updateLastName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Doe',
            labelText: AuthLocalization.lastNameHint,
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget emailField(AuthBloc blocState) {
    return StreamBuilder(
      stream: blocState.emailStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return TextField(
          onChanged: blocState.updateEmail,
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

  Widget passwordField(AuthBloc blocState) {
    return StreamBuilder(
      stream: blocState.passwordStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return TextField(
          onChanged: blocState.updatePassword,
          obscureText: true,
          decoration: InputDecoration(
            labelText: AuthLocalization.passwordHint,
            errorText: snapshot.error,
          ),
        );
      },
    );
  }
}
