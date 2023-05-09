import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
                title: const Text(
                  'User Information',
                  style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFFFFFFFF),
                  )
                ),
                onPressed: (context) => {Navigator.pushNamed(context, '/settings/user_settings')},
              ),
              SettingsTile(
                title: const Text(
                  'Goal Settings',
                  style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFFFFFFFF),
                  )
                ),
                onPressed: (context) => {},
              ),
              SettingsTile(
                title: const Text(
                  'Allergies',
                  style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFFFFFFFF),
                  )
                ),
                onPressed: (context) => {},
              ),
              SettingsTile(
                title: const Text(
                  'Application Settings',
                  style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFFFFFFFF),
                  )
                ),
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
  int height=140;
  // From Harsh Pipaliya
  // https://stackoverflow.com/questions/49778217/how-to-create-a-dialog-that-is-able-to-accept-text-input-and-show-result-in-flut
  Future<void> _displayTextInputDialog(BuildContext context, {String title='', required TextEditingController controller, required void Function(String) onTextEntered}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
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
                onTextEntered(controller.text);
                setState((){});
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _displayIntInputDialog(BuildContext context, {String title='', required TextEditingController controller, required void Function(int) onIntEntered}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
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
                
                int? val = int.tryParse(controller.text);
                if(val == null)
                {
                  Navigator.pop(context);
                  showDialog(context: context, builder: (context) {
                    return const AlertDialog(
                      title: Text("Invalid input"),
                      content: Text("Enter valid integer!"),
                    );
                  });
                }
                else
                {
                  onIntEntered(val);
                  setState((){});
                  Navigator.pop(context);
                }
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
                  _displayTextInputDialog(context, 
                  title: "Enter username: ", 
                  controller: TextEditingController(text: userName),
                  onTextEntered: (s) => {userName = s}),
                },
              ),
              SettingsTile(
                title: const Text('Height'),
                trailing: Text(height.toString()),
                onPressed: (context) => {
                  _displayIntInputDialog(context, 
                  title: "Enter height: ", 
                  controller: TextEditingController(text: height.toString()),
                  onIntEntered: (val) {height = val;}
                  ),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}