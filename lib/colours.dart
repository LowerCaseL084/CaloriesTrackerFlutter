import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF4F56A9),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFE0E0FF),
  onPrimaryContainer: Color(0xFF030865),
  secondary: Color(0xFF744C9D),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFF0DBFF),
  onSecondaryContainer: Color(0xFF2C0051),
  tertiary: Color(0xFF874589),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD6FA),
  onTertiaryContainer: Color(0xFF37003C),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFBFF),
  onBackground: Color(0xFF030865),
  surface: Color(0xFFDFDDDF),
  onSurface: Color(0xFF030865),
  surfaceVariant: Color(0xFFE3E1EC),
  onSurfaceVariant: Color(0xFF46464F),
  outline: Color(0xFF777680),
  onInverseSurface: Color(0xFFF1EFFF),
  inverseSurface: Color(0xFF1E2578),
  inversePrimary: Color(0xFFBEC2FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF4F56A9),
  outlineVariant: Color(0xFFC7C5D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFBEC2FF),
  onPrimary: Color(0xFF1F2578),
  primaryContainer: Color(0xFF373E90),
  onPrimaryContainer: Color(0xFFE0E0FF),
  secondary: Color(0xFFDCB8FF),
  onSecondary: Color(0xFF431A6B),
  secondaryContainer: Color(0xFF5B3383),
  onSecondaryContainer: Color(0xFFF0DBFF),
  tertiary: Color(0xFFFBACF8),
  onTertiary: Color(0xFF521457),
  tertiaryContainer: Color(0xFF6C2D70),
  onTertiaryContainer: Color(0xFFFFD6FA),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF030865),
  onBackground: Color(0xFFE0E0FF),
  surface: Color(0xFF101295),
  onSurface: Color(0xFFE0E0FF),
  surfaceVariant: Color(0xFF46464F),
  onSurfaceVariant: Color(0xFFC7C5D0),
  outline: Color(0xFF91909A),
  onInverseSurface: Color(0xFF030865),
  inverseSurface: Color(0xFFE0E0FF),
  inversePrimary: Color(0xFF4F56A9),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFBEC2FF),
  outlineVariant: Color(0xFF46464F),
  scrim: Color(0xFF000000),
);

class ThemeChangeNotifier with ChangeNotifier {
  ThemeChangeNotifier({required this.theme});
  ThemeMode theme;
  void changeTheme(String theme)
  {
    this.theme =  theme=='light'?ThemeMode.light:(theme == 'dark'?ThemeMode.dark:ThemeMode.system);
    notifyListeners();
  }
}