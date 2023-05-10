import 'package:flutter/material.dart';
import 'package:calories_tracker/settings.dart';

void main() {
  runApp(const CaloriesApp());
}

class CaloriesApp extends StatelessWidget {
  const CaloriesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      home: const CaloriesHomePage(title: 'Home Page'),
      initialRoute: '/',
      routes: {
        '/settings' :(context) => const CaloriesSettingsPage(title: "Settings"),
        '/settings/user_settings' :(context) => CaloriesUserSettingsPage(title: "User Settings"),
        '/settings/goal_settings' :(context) => CaloriesGoalSettingsPage(title: "User Settings"),
      }
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
      backgroundColor: const Color(0xFF070A52),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF00337C),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Today\'s Goal:',
              style: TextStyle(
                fontSize: 25.0,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context, '/settings');},
        tooltip: 'Settings',
        child: const Icon(Icons.add),
      ), 
    );
  }
}