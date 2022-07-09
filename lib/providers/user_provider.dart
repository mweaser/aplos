import 'package:flutter/material.dart';
import '../models/user.dart';
import '../resources/authentication_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthenticationMethods _authenticationMethods = AuthenticationMethods();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authenticationMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
