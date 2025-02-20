import 'package:shared_preferences/shared_preferences.dart';

class UserConfigModel {
  UserConfigModel(this._preferences);

  static const String _isDarkModeKey = "darkMode";

  bool get isDarkMode => _preferences.getBool(_isDarkModeKey) ?? false;

  final SharedPreferences _preferences;

  Future<void> setIsDarkMode(bool isDarkMode) async {
    await _preferences.setBool(_isDarkModeKey, isDarkMode);
  }
}
