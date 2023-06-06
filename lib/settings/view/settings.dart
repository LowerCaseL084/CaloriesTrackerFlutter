import 'package:flutter/material.dart';

// Settings page

class CaloriesSettingsPage extends StatelessWidget {
  const CaloriesSettingsPage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: const Text('User Information',
                style: TextStyle(
                  fontSize: 25.0,
                )),
            onTap: () =>
                {Navigator.pushNamed(context, '/settings/user_settings')},
          ),
          ListTile(
            title: const Text('Goal Settings',
                style: TextStyle(
                  fontSize: 25.0,
                )),
            onTap: () =>
                {Navigator.pushNamed(context, '/settings/goal_settings')},
          ),
          ListTile(
            title: const Text('Allergies',
                style: TextStyle(
                  fontSize: 25.0,
                )),
            onTap: () =>
                {Navigator.pushNamed(context, '/settings/allergies_list')},
          ),
          ListTile(
            title: const Text('Application Settings',
                style: TextStyle(
                  fontSize: 25.0,
                )),
            onTap: () => {
              Navigator.pushNamed(context, '/settings/application_settings')
            },
          ),
        ],
      ),
    );
  }
}
