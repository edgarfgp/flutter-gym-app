import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String name;
  String lastName;
  String email;
  String password;
  List<User> users;

  User({
    this.key,
    this.name,
    this.lastName,
    this.email,
    this.password,
  });

  factory User.fromJson(Map<User, dynamic> parsedJson) {
    return User(
        key: parsedJson['key'],
        name: parsedJson['name'],
        lastName: parsedJson['lastName'],
        email: parsedJson['email']);
  }

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        lastName = snapshot.value["lastName"],
        email = snapshot.value["email"],
        password = snapshot.value["password"];

  toJson() {
    return <String, dynamic>{
      "key": key,
      "name": name,
      "lastName": lastName,
      "email": email,
    };
  }
}
