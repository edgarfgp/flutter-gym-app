import 'dart:async';

import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/services/auth_service.dart';

abstract class ApplicationBlocAPI {
  Future<bool> isUserLogged();
}

class ApplicationBloc implements BlocBase, ApplicationBlocAPI {
  Future<bool> isUserLogged() async {
    return await authService.currentUser() != null;
  }

  @override
  void dispose() {

  }
}
