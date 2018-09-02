import 'dart:async';

import 'package:gymapp/models/user.dart';
import 'package:gymapp/services/database_service.dart';

class MockData extends DatabaseServiceAPI {
  @override
  Future<String> addUserData(User user) {
    // TODO: implement addUserData
  }

  @override
  User getCurrentUserData() {
    return User(
      key: '',
      name: 'Edgar',
      lastName: 'Gonzalez',
      email: 'edgargonzalez.info@gmail.com',
    );
  }

  @override
  Future getUserAccountKey() {
    // TODO: implement getUserAccountKey
  }
}

DatabaseServiceAPI mockData = MockData();
