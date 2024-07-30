import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  UserViewModel() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      _user = User.fromJson(userMap);
    } else {
      _user = User(
        userID: null,
        name: null,
        sevicePack: null,
        numSevicePack: null,
        expiry: null,
      );
      _saveUser();
    }
    notifyListeners();
  }

  Future<void> _saveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(_user?.toJson());
    await prefs.setString('user', userJson);
  }

  void updateUser(User user) {
    _user = user;
    _saveUser();
    notifyListeners();
  }
}
