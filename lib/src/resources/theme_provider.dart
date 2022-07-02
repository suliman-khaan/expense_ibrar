import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    textButtonTheme:TextButtonThemeData(
      style: TextButton.styleFrom(primary: Colors.white)
    )
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    textButtonTheme:TextButtonThemeData(
      style: TextButton.styleFrom(primary: Colors.black)
    )
  );
}
