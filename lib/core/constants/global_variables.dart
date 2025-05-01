import 'package:flutter/material.dart';

double deviceHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

String sessionId = '';

String userName = '';

class UserProvider with ChangeNotifier {
  String _userId = '';

  String get userId => _userId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }
}
