import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppProvider with ChangeNotifier {
  final Box _box = Hive.box('cash_counter_db');

  String _language = 'Hindi';
  bool _isPremium = false;
  bool _fingerprintLock = true;
  ThemeMode _themeMode = ThemeMode.light;

  String get language => _language;
  bool get isPremium => _isPremium;
  bool get fingerprintLock => _fingerprintLock;
  ThemeMode get themeMode => _themeMode;

  AppProvider() {
    _loadSettings();
  }

  void _loadSettings() {
    _language = _box.get('language', defaultValue: 'Hindi');
    _isPremium = _box.get('isPremium', defaultValue: false);
    _fingerprintLock = _box.get('fingerprintLock', defaultValue: true);
    notifyListeners();
  }

  void setLanguage(String lang) {
    _language = lang;
    _box.put('language', lang);
    notifyListeners();
  }

  void toggleFingerprint(bool value) {
    _fingerprintLock = value;
    _box.put('fingerprintLock', value);
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
