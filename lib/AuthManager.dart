import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager extends ChangeNotifier {
  late SharedPreferences _prefs;
  List<String> _userCategories = [];

  List<String> get userCategories => _userCategories;
  String get userId {
    return _prefs.getString('userId') ?? '';
  }

  String get Email {
    return _prefs.getString('Email') ?? '';
  }

  String get username {
    return _prefs.getString('username') ?? '';
  }

  String get Nickname {
    return _prefs.getString('Nickname') ?? '';
  }

  // init 메서드 정의
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    // 초기화가 완료되면 notifyListeners 호출
    notifyListeners();
  }

  bool get isLoggedIn {
    return _prefs.getBool('isLoggedIn') ?? false;
  }

  void setLoggedIn(bool value) {
    _prefs.setBool('isLoggedIn', value);
    notifyListeners();
  }

  void setUsername(String value) {
    _prefs.setString('username', value);
    notifyListeners();
  }

  void setUserNickname(String value) {
    _prefs.setString('Nickname', value);
    notifyListeners();
  }

  void setUserEmail(String value) {
    _prefs.setString('Email', value);
    notifyListeners();
  }

  // 사용자 카테고리를 리스트로 설정
  void setUserCategories(List<String> categories) {
    _userCategories = categories;
    notifyListeners();
  }

  void setUserId(String value) {
    _prefs.setString('userId', value);
    notifyListeners();
  }
}
