import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymapp/blocs/bloc_provider.dart';
import 'package:gymapp/models/user.dart';
import 'package:gymapp/services/auth_service.dart';
import 'package:gymapp/services/database_service.dart';
import 'package:gymapp/utils/auth_validators.dart';

import 'package:rxdart/rxdart.dart';

abstract class AuthBlocAPI {
  Future<FirebaseUser> logIn();
  Future<FirebaseUser> resgister();
  Future<void> forgetDetails();
  Future<void> logOut();
}

class AuthBloc implements BlocBase, AuthBlocAPI {
  final nameController = BehaviorSubject<String>();
  final lastNameController = BehaviorSubject<String>();
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();

  Stream<String> get nameStream => nameController.stream.transform(AuthValidator.nameValidation);
  Stream<String> get lastNameStream =>
      lastNameController.stream.transform(AuthValidator.lastNameValidation);
  Stream<String> get emailStream => emailController.stream.transform(AuthValidator.emailValidation);
  Stream<String> get passwordStream =>
      passwordController.stream.transform(AuthValidator.passwordValidation);

  Function(String) get updateName => nameController.sink.add;
  Function(String) get updateLastName => lastNameController.sink.add;
  Function(String) get updateEmail => emailController.sink.add;
  Function(String) get updatePassword => passwordController.sink.add;

  Stream<bool> get submitLogin =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Stream<bool> get submitRegister => Observable.combineLatest4(
      nameStream, lastNameStream, emailStream, passwordStream, (n, l, e, p) => true);

  @override
  Future<FirebaseUser> logIn() async {
    final validEmail = emailController.value;
    final validPassword = passwordController.value;
    return authService.signIn(validEmail, validPassword);
  }

  @override
  Future<FirebaseUser> resgister() async {
    final validName = nameController.value;
    final validLastName = lastNameController.value;
    final validEmail = emailController.value;
    final validPassword = passwordController.value;

    var user = new User(
        name: validName, lastName: validLastName, email: validEmail, password: validPassword);
    return await authService.register(user).then((value) {
      if (value.uid.isNotEmpty) {
        databaseService.addUserData(user);
      }
    });
  }

  @override
  Future<void> forgetDetails() async {
    final validEmail = emailController.value;
    await authService.forgotMyDetails(validEmail);
  }

  @override
  dispose() {
    nameController.close();
    lastNameController.close();
    emailController.close();
    passwordController.close();
  }

  @override
  Future<void> logOut() {
    authService.signOut();
  }
}
