import 'dart:convert';
import 'package:ethiosolar_app/app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class PreferenceKeys {
  static const token = 'token';
  static const preferedLanguage = 'PreferedLanguage';
  static const userData = 'userData';
}

class UserSession {
  static String userId = '';
  static Future<void> setUserToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(PreferenceKeys.token);
      return;
    }
    await prefs.setString(PreferenceKeys.token, token);
  }

  static Future<String> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.token) ?? '';
  }

  static Future<String> getUserId() async {
    final token = await getUserToken();
    final payload = Jwt.parseJwt(token);
    int id = payload["payload"]["id"];
    return id.toString();
  }

  static Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceKeys.preferedLanguage, lang);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.preferedLanguage) ?? '';
  }

  static Future<void> setUserData(UserModel data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceKeys.userData, jsonEncode(data));
  }

  static Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(PreferenceKeys.userData);

    if (userData == null || userData.isEmpty || userData == '{}') {
      return null;
    }
    return UserModel.fromJson(jsonDecode(userData));
  }

  static Future<bool> isLoggedIn() async => await getUserToken() != '';
}
