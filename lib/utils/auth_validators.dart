import 'dart:async';
import 'package:gymapp/localization/auth_localization.dart';

class AuthValidator {
  static final nameValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    String nameRule = AuthLocalization.nameValidationPattern;
    RegExp regExp = new RegExp(nameRule);
    if (regExp.hasMatch(name)) {
      sink.add(name);
    } else {
      sink.addError(AuthLocalization.nameValidationErrorMessage);
    }
  });

  static final lastNameValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (lastName, sink) {
    String lastNameRule = AuthLocalization.nameValidationPattern;
    RegExp regExp = new RegExp(lastNameRule);
    if (regExp.hasMatch(lastName)) {
      sink.add(lastName);
    } else {
      sink.addError(AuthLocalization.lastNameValidationErrorMessage);
    }
  });
  static final emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String emailRule = AuthLocalization.emailValidationPattern;
    RegExp regExp = new RegExp(emailRule);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError(AuthLocalization.emailValidationErrorMessage);
    }
  });

  static final passwordValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    // String passwordRule = AuthLocalizations().passwordValidationPatter;
    // RegExp regExp = new RegExp(passwordRule);
    //if (regExp.hasMatch(password)) {
    if (password.length > 5) {
      sink.add(password);
    } else {
      sink.addError(AuthLocalization.passwordValidationErrorMessage);
    }
  });
}
