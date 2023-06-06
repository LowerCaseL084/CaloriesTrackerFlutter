import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:calories_tracker/calendar.dart';
import 'package:calories_tracker/theme/colours.dart';
import 'package:calories_tracker/theme/theme_change_provider.dart';
import 'package:calories_tracker/camera.dart';

import 'package:calories_tracker/home_page/home_page_view.dart';
import 'package:calories_tracker/home_page/splash_screen_view.dart';

import 'package:calories_tracker/settings/view/settings.dart';
import 'package:calories_tracker/settings/view/user_settings.dart';
import 'package:calories_tracker/settings/view/goal_settings.dart';
import 'package:calories_tracker/settings/view/application_settings.dart';
import 'package:calories_tracker/settings/view/allergies_settings.dart';

import 'package:calories_tracker/data/view.dart';

Future<void> main() async {
  runApp(const ProviderScope(child: CaloriesApp()));
}

class CaloriesApp extends ConsumerWidget {
  const CaloriesApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncTheme = ref.watch(themeChangeNotifierProvider);
    return asyncTheme.when(
        loading: () =>
            const MaterialApp(title: 'Calorie Tracker', home: SplashScreen()),
        error: (error, stackTrace) {
          return const Text("Error loading preferences!");
        },
        data: (theme) {
          return MaterialApp(
              title: 'Calorie Tracker',
              theme:
                  ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
              darkTheme:
                  ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
              themeMode: theme,
              home: const CaloriesHomePage(title: 'Home Page'),
              initialRoute: '/',
              routes: {
                '/settings': (context) =>
                    const CaloriesSettingsPage(title: "Settings"),
                '/settings/user_settings': (context) =>
                    const CaloriesUserSettingsPage(title: "User Settings"),
                '/settings/goal_settings': (context) =>
                    const CaloriesGoalSettingsPage(title: "Goal Settings"),
                '/settings/allergies_list': (context) =>
                    const CaloriesAllergiesListPage(title: "Allergies"),
                '/settings/application_settings': (context) =>
                    const CaloriesApplicationSettingsPage(
                        title: "Application Settings"),
                '/calendar': (context) =>
                    const CalendarSettingsPage(title: "Calendar"),
                '/picture_taking': (context) =>
                    const TakePictureScreen(title: "Take Picture"),
                '/data/data_view': (context) => DataPage(title: "History"),
              });
        });
  }
}
