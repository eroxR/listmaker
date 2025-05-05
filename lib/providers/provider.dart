import 'package:flutter/material.dart';
import 'package:listmaker/providers/app_color_scheme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void togleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setSystemTheme() {
    _themeMode = ThemeMode.system; // Cambiar al tema del sistema
    notifyListeners();
  }
}

extension ColorExtension on BuildContext {
  AppColorScheme get color => AppColorScheme.of(this);
}
