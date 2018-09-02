class AuthLocalization {
  static String get loginTitle => "Login";
  static String get submit => "Submit";
  static String get emailHint => "Enter you email";
  static String get nameHint => "Enter you name";
  static String get lastNameHint => "Enter you last name";
  static String get passwordHint => "Enter you password";
  static String get forgetMyDetails => "Forgot your Password ?";
  static String get registerTitle => "Resgiter";
  static String get registerSubtitle => "Please complete the following fields";
  static String get nameValidationPattern => r'^[a-zA-Z\s]+$';
  static String get emailValidationPattern =>
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String get passwordValidationPatter =>
      '((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#%]).{6,10})';
  static String get emailValidationErrorMessage => 'Please enter a valid email address';
  // String get passwordValidationErrorMessage =>
  //     'digit, lowercase, uppercase, symbol "@#%" min. 6 to max. 10';
  static String get passwordValidationErrorMessage => 'min. 6 to max. 10';
  static String get nameValidationErrorMessage => 'Enter a valid name';
  static String get lastNameValidationErrorMessage => "Enter a valid last name";
}
