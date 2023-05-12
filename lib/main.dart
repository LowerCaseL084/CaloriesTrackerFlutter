import 'package:calories_tracker/calendar.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/colours.dart';
import 'package:calories_tracker/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String theme =
      (await SharedPreferences.getInstance()).getString('theme') ?? 'system';
  ThemeMode themeMode = ThemeMode.system;
  if (theme == 'light') {
    themeMode = ThemeMode.light;
  } else if (theme == 'dark') {
    themeMode = ThemeMode.dark;
  }
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeChangeNotifier(theme: themeMode),
      child: const CaloriesApp()));
}

class CaloriesApp extends StatelessWidget {
  const CaloriesApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeNotifier>(
      builder: (context, value, child) {
        return MaterialApp(
            title: 'Calorie Tracker',
            theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
            darkTheme:
                ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            themeMode: value.theme,
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

            });
      },
    );
  }
}

class CaloriesHomePage extends StatefulWidget {
  const CaloriesHomePage({super.key, required this.title});

  final String title;

  @override
  State<CaloriesHomePage> createState() => _CaloriesHomePageState();
}

class _CaloriesHomePageState extends State<CaloriesHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ThemeColoursDefault.BACKGROUND_COLOUR,
      appBar: AppBar(
        title: Text(widget.title),
        //backgroundColor: ThemeColoursDefault.APP_BAR_COLOUR,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Today\'s Goal:',
              style: TextStyle(
                fontSize: 25.0,
                //color: ThemeColoursDefault.TEXT_COLOUR,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                    size: 40,
                  ),
                ),
                const Text('Settings'),
              ],
            ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                  ),
                ),
                const Text('Add entry'),
              ],
            ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,

                  onPressed: () {
                    Navigator.pushNamed(context, '/calendar');
                  },

                  onPressed: () {},

                  icon: const Icon(
                    Icons.calendar_month,
                    size: 40,
                  ),
                ),
                const Text('Calendar'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
