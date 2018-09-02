import 'package:flutter/material.dart';
import 'package:gymapp/blocs/auth_bloc.dart';
import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/localization/auth_localization.dart';
import 'package:gymapp/utils/common.dart';

class ForgetDetailsPage extends StatefulWidget {
  ForgetDetailsPageState createState() => ForgetDetailsPageState();
}

class ForgetDetailsPageState extends State<ForgetDetailsPage> {
  final GlobalKey _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = BlocProvider.of<AuthBloc>(context);
    Widget emailField(AuthBloc bloc) {
      return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onChanged: bloc.updateEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'example@mail.com',
                labelText: AuthLocalization.emailHint,
                errorText: snapshot.error,
              ),
            ),
          );
        },
      );
    }

    _handleForget() {
      bloc.forgetDetails().then((value) {
        Navigator.pushNamed(context, "/login");
      }).catchError((error) {
        UI.showInSnackBar(_scaffoldKey, error.message);
      });
    }

    _forgetButton(AuthBloc bloc) {
      return StreamBuilder(
          stream: bloc.emailStream,
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
                        Text(AuthLocalization.submit, style: Theme.of(context).textTheme.subhead),
                    color: snapshot.hasData ? _activeColor : _inActiveColor,
                    onPressed: () => snapshot.hasData ? _handleForget() : null));
          });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AuthLocalization.forgetMyDetails),
        ),
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey[100],
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 120.0),
          children: <Widget>[
            Text(AuthLocalization.forgetMyDetails,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .apply(color: Theme.of(context).primaryColor)
                    .apply(fontSizeDelta: 6.0),
                textAlign: TextAlign.center),
            const SizedBox(height: 30.0),
            emailField(bloc),
            const SizedBox(height: 40.0),
            _forgetButton(bloc)
          ],
        ),
      ),
    );
  }
}
