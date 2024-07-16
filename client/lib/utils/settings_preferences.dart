import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsPreferences {
  static const String _keyFontSize = 'fontSize';
  static const String _keyBackgroundColor = 'backgroundColor';
  static const String _keyTextColor = 'textColor';
  static const String _keyDarkMode = 'darkMode';
  static const String _keyLanguage = 'language';

  static Future<double> getFontSize() async {
    var storage = const FlutterSecureStorage();
    String? value = await storage.read(key: _keyFontSize);
    return double.parse(value ?? '15.0');
  }

  static Future<void> setFontSize(double value) async {
    var storage = const FlutterSecureStorage();
    await storage.write(key: _keyFontSize, value: value.toString());
    return;
  }

  static Future<int> getBackgroundColor() async {
    var storage = const FlutterSecureStorage();
    String? value = await storage.read(key: _keyBackgroundColor);
    return int.parse(value ?? '4287002859');
  }

  static Future<void> setBackgroundColor(int color) async {
    var storage = const FlutterSecureStorage();
    await storage.write(key: _keyBackgroundColor, value: color.toString());
    return;
  }

  static Future<int> getTextColor() async {
    var storage = const FlutterSecureStorage();
    String? value = await storage.read(key: _keyTextColor);
    return int.parse(value ?? '4294967295');
  }

  static Future<void> setTextColor(int color) async {
    var storage = const FlutterSecureStorage();
    await storage.write(key: _keyTextColor, value: color.toString());
    return;
  }

  static Future<bool> getDarkMode() async {
    var storage = const FlutterSecureStorage();
    String? value = await storage.read(key: _keyDarkMode);
    return value == null ? true : value == 'true';
  }

  static Future<void> setDarkMode(bool value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: _keyDarkMode, value: value.toString());
    return;
  }

  static Future<String> getLanguage() async {
    var storage = const FlutterSecureStorage();
    String? value = await storage.read(key: _keyLanguage);
    return value ?? 'en';
  }

  static Future<void> setLanguage(String language) async {
    var storage = const FlutterSecureStorage();
    await storage.write(key: _keyLanguage, value: language);
    return;
  }
}
