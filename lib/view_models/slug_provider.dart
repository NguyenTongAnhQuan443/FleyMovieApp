import 'package:flutter/material.dart';

class SlugProvider with ChangeNotifier {
  String _slug = '';

  String get slug => _slug;

  void setSlug(String slug) {
    _slug = slug;
    notifyListeners();
  }
}
