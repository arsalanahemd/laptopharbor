// lib/providers/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = true;
  late SharedPreferences _prefs;

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  // Load theme preference from storage
  Future<void> _loadThemeFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkTheme = _prefs.getBool('isDarkTheme') ?? true;
    notifyListeners();
  }

  // Toggle theme
  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _prefs.setBool('isDarkTheme', _isDarkTheme);
    notifyListeners();
  }

  // Set specific theme
  Future<void> setTheme(bool isDark) async {
    _isDarkTheme = isDark;
    await _prefs.setBool('isDarkTheme', _isDarkTheme);
    notifyListeners();
  }

  // Get theme data
  ThemeData get themeData {
    return _isDarkTheme ? _darkTheme : _lightTheme;
  }

  // Dark Theme
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: const Color(0xFF1E40AF),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E293B),
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E293B),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF3B82F6),
      secondary: Color(0xFF60A5FA),
      surface: Color(0xFF1E293B),
      background: Color(0xFF0F172A),
    ),
  );

  // Light Theme
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: const Color(0xFF3B82F6),
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF3B82F6),
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF3B82F6),
      secondary: Color(0xFF60A5FA),
      surface: Colors.white,
      background: Color(0xFFF8FAFC),
    ),
  );
}