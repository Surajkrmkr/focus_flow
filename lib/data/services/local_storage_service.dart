
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _isFirstTimeKey = 'is_first_time';

  static Future<void> setFirstTimeFalse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstTimeKey, false);
  }

  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstTimeKey) ?? true;
  }
}
