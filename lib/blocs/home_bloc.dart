import 'dart:async';
import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/models/user.dart';
import 'package:gymapp/services/auth_service.dart';
import 'package:gymapp/services/mock/mock_data.dart';

class HomeBloc extends BlocBase {

  User getUserData() {
    return mockData.getCurrentUserData();
  }

  Future<void> logOut() async {
    return await authService.signOut();
  }

  @override
  void dispose() {}
}
