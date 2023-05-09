import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';

class CaloriesSettingsPage extends StatelessWidget {
  const CaloriesSettingsPage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: const Text('User Information'),
                onPressed: (context) => {Navigator.pushNamed(context, '/settings/user_settings')},
              ),
              SettingsTile(
                title: const Text('Goal Settings'),
                onPressed: (context) => {},
              ),
              SettingsTile(
                title: const Text('Allergies'),
                onPressed: (context) => {},
              ),
              SettingsTile(
                title: const Text('Application Settings'),
                onPressed: (context) => {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CaloriesUserSettingsPage extends StatefulWidget {
  const CaloriesUserSettingsPage({super.key, required this.title});
  final String title;
  @override
  State<CaloriesUserSettingsPage> createState() => _CaloriesUserSettingsPageState();
}
class _CaloriesUserSettingsPageState extends State<CaloriesUserSettingsPage> {
  String userName='Aishwarya';

  // From Harsh Pipaliya
  // https://stackoverflow.com/questions/49778217/how-to-create-a-dialog-that-is-able-to-accept-text-input-and-show-result-in-flut
  final TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context, String title, String fieldText, void Function(String) action) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: fieldText),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                action(_textFieldController.text);
                setState((){});
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: const Text('Name'),
                trailing: Text(userName),
                onPressed: (context) => {
                  _displayTextInputDialog(context, "Enter username: ", userName, (s) => {userName = s}),
                  },
              ),
            ],
          ),
        ],
      ),
    );
  }
}