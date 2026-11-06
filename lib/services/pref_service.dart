import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  final SharedPreferences _prefs;

  PrefService(this._prefs);

  static const String _kOpenCount = 'open_count';
  static const String _kDarkMode = 'is_dark_mode';

  static Future<PrefService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefService(prefs);
  }

  // Getter & Setter untuk Open Count
  int get openCount => _prefs.getInt(_kOpenCount) ?? 0;

  Future<void> incrementOpenCount() async {
    await _prefs.setInt(_kOpenCount, openCount + 1);
  }

  // Getter & Setter untuk Dark Mode
  bool get isDarkMode => _prefs.getBool(_kDarkMode) ?? false;

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_kDarkMode, value);
  }
}