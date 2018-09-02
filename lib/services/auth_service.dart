import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymapp/models/user.dart';

abstract class AuthServiceAPI {
  Future<FirebaseUser> currentUser();
  Future<void> forgotMyDetails(String email);
  Future<FirebaseUser> register(User user);
  Future<FirebaseUser> signIn(String email, String password);
  Future<void> signOut();
  Future<String> currentUserKey();
}

class AuthService implements AuthServiceAPI {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> currentUser() async {
    return await _auth.currentUser();
  }

  @override
  forgotMyDetails(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<FirebaseUser> register(User user) async {
    return await _auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
  }

  @override
  Future<FirebaseUser> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  @override
  Future<String> currentUserKey() async {
    FirebaseUser user = await _auth.currentUser();
    return user?.uid;
  }
}

AuthServiceAPI authService = AuthService();
