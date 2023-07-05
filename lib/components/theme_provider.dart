// import 'package:flutter/material.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeMode themeMode = ThemeMode.light;

//   bool get isDarkMode => themeMode == ThemeMode.dark;

//   void toggleTheme(bool isOn) {
//     themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
// }

// class MyThemes {
//   static final darkTheme = ThemeData(
//     scaffoldBackgroundColor: Colors.black87,
//     colorScheme: ColorScheme.dark(),
//   );

//   static final lightTheme = ThemeData(
//     scaffoldBackgroundColor: Colors.white,
//     colorScheme: ColorScheme.light(),
//   );
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider with ChangeNotifier {
//   ThemeMode themeMode = ThemeMode.light;
//   final String _prefKey = 'theme_preference';

//   bool get isDarkMode => themeMode == ThemeMode.dark;

//   Future<void> toggleTheme(bool isOn) async {
//     themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();

//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_prefKey, isOn);
//   }

//   Future<void> initializeTheme() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final bool? isDarkMode = prefs.getBool(_prefKey);

//     if (isDarkMode != null) {
//       themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
//     } else {
//       themeMode = ThemeMode.light;
//     }

//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  static const String themePreferenceKey = 'themePreference';

  ThemeProvider() {
    _loadThemePreference();
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    _saveThemePreference();
    notifyListeners();
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(themePreferenceKey) ?? false;
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = themeMode == ThemeMode.dark;
    await prefs.setBool(themePreferenceKey, isDarkMode);
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black87,
    colorScheme: ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
  );
}
