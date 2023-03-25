import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  // themeMode를 편하게 String으로 바꿔 저장하려고 replaceAll 함수를 사용했습니다.
  setThemeMode(ThemeMode newThemeMode) {
    themeMode = newThemeMode;
    saveThemeModePrefs(themeMode.toString().replaceAll("ThemeMode.", ""));
    notifyListeners();
  }

  saveThemeModePrefs(String value) async {
    final prefs = await SharedPreferences.getInstance();
    // key값은 "themeMode", 저장하는 value값은 String 타입의 "light" or "dark" or "system" 입니다.
    await prefs.setString("themeMode", value);
  }

  ThemeProvider({ThemeMode initThemeMode = ThemeMode.light}) {
    themeMode = initThemeMode;
  }
}
