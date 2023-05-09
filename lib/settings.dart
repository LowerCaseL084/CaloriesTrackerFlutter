import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';

class CaloriesSettingsPage extends StatelessWidget {
  const CaloriesSettingsPage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070A52),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF00337C),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: const Text('User Information',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFF000000),
                    )),
                onPressed: (context) =>
                    {Navigator.pushNamed(context, '/settings/user_settings')},
              ),
              SettingsTile(
                title: const Text('Goal Settings',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFF000000),
                    )),
                onPressed: (context) => {},
              ),
              SettingsTile(
                title: const Text('Allergies',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFF000000),
                    )),
                onPressed: (context) => {},
              ),
              SettingsTile(
                title: const Text('Application Settings',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFF000000),
                    )),
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
  State<CaloriesUserSettingsPage> createState() =>
      _CaloriesUserSettingsPageState();
}

String uName = 'Enter Name';//To be kept in a textfile containing user data within secondary storage

class _CaloriesUserSettingsPageState extends State<CaloriesUserSettingsPage> {
  String userName = uName;

  // From Harsh Pipaliya
  // https://stackoverflow.com/questions/49778217/how-to-create-a-dialog-that-is-able-to-accept-text-input-and-show-result-in-flut
  final TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context, String title,
      String fieldText, void Function(String) action) async {
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
                uName = _textFieldController.text;
                setState(() {});
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
        backgroundColor: const Color(0xFF00337C),
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
                  _displayTextInputDialog(context, "Enter username: ", userName,
                      (s) => {userName = s}),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
