import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeChangeNotifierProvider =
    AsyncNotifierProvider<ThemeChangeNotifier, ThemeMode>(
        () => ThemeChangeNotifier());

class ThemeChangeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    state = const AsyncValue.loading();
    return await loadTheme();
  }

  Future<ThemeMode> loadTheme() async {
    WidgetsFlutterBinding.ensureInitialized();
    String theme =
        (await SharedPreferences.getInstance()).getString('theme') ?? 'system';
    await Future.delayed(const Duration(seconds: 3));
    return theme == 'light'
        ? ThemeMode.light
        : (theme == 'dark' ? ThemeMode.dark : ThemeMode.system);
  }

  void changeTheme(ThemeMode theme) {
    state = AsyncValue.data(theme);
  }
}
