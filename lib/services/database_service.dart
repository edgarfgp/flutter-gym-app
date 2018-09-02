import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:gymapp/models/user.dart';
import 'package:gymapp/services/auth_service.dart';

abstract class DatabaseServiceAPI {
  User getCurrentUserData();
  Future<String> addUserData(User user);
  Future<dynamic> getUserAccountKey();
}

class DatabaseService implements DatabaseServiceAPI {
  @override
  Future<String> addUserData(User user) async {
    String accountKey = await getUserAccountKey();
    user.key = accountKey;

    DatabaseReference reference = FirebaseDatabase.instance.reference().child("users").push();

    reference.set(user.toJson());
    return reference.key;
  }

  Future<dynamic> getUserAccountKey() {
    return authService.currentUserKey();
  }

  @override
  User getCurrentUserData() {
    //FIXME Fecth Data from firebase
  }
}

DatabaseServiceAPI databaseService = DatabaseService();
