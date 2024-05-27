import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    await prefs.setInt("tokenTimestamp", DateTime.now().millisecondsSinceEpoch);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Use 'token' as the key
  }

  static Future<int?> getTokenTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('tokenTimestamp');
  }

  static Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("tokenTimestamp");
  }
}
