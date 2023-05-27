import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  Future setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("token", value);
  }

  Future setUserId(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("userId", value);
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  Future<String?> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('userId');
  }

  Future Logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}