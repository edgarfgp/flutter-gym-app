import 'package:flutter/material.dart';
import 'package:gymapp/blocs/auth_bloc.dart';
import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/models/user.dart';
import 'package:gymapp/pages/auth/login.dart';

class NavHubDrawer extends StatelessWidget {
  final User userData;
  NavHubDrawer(this.userData);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                userData.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                userData.email,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.account_circle,
                  size: 60.0,
                  color: Colors.white,
                ),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Divider(
              height: 5.0,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            new NavHubItem(
              icon: Icons.exit_to_app,
              text: "Log out",
              navigateTo: LoginPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class NavHubItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget navigateTo;
  const NavHubItem({
    this.icon,
    this.text,
    this.navigateTo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);

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

    return ListTile(
      title: Text(text, style: TextStyle(color: Colors.white)),
      leading: Icon(icon, color: Colors.white),
      onTap: () {
        Navigator.of(context).pop();
        bloc.logOut();
        _navigateTo(navigateTo);
      },
    );
  }
}
