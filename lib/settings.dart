import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:calories_tracker/colours.dart';

mixin InputDialog {
  // From Harsh Pipaliya
  // https://stackoverflow.com/questions/49778217/how-to-create-a-dialog-that-is-able-to-accept-text-input-and-show-result-in-flut
  
  Future<void> _displayTextInputDialog(BuildContext context, {String title='', required TextEditingController controller, required void Function(String) onTextEntered}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter name:"),
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
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

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
                title: const Text(
                  'User Information',
                  style: TextStyle(
                    fontSize: 25.0,
                  )
                ),
                onPressed: (context) => {Navigator.pushNamed(context, '/settings/user_settings')},
              ),
              SettingsTile(
                title: const Text(
                  'Goal Settings',
                  style: TextStyle(
                    fontSize: 25.0,
                  )
                ),
                onPressed: (context) => {Navigator.pushNamed(context, '/settings/goal_settings')},
              ),
              SettingsTile(
                title: const Text(
                  'Allergies',
                  style: TextStyle(
                    fontSize: 25.0,
                  )
                ),
                onPressed: (context) => {},
              ),
              SettingsTile(
                title: const Text(
                  'Application Settings',
                  style: TextStyle(
                    fontSize: 25.0,
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
  CaloriesUserSettingsPage({super.key, required this.title});
  final String title;
  String userName='Aishwarya';
  int height=140;
  int weight=50;
  @override
  State<CaloriesUserSettingsPage> createState() => _CaloriesUserSettingsPageState();
}

class _CaloriesUserSettingsPageState extends State<CaloriesUserSettingsPage> with InputDialog {

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
                title: const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 25.0,
                  )
                ),
                trailing: Text(
                  widget.userName,
                  style: const TextStyle(
                    fontSize: 25.0,
                  )
                ),
                onPressed: (context) => {
                  _displayTextInputDialog(context, 
                  title: "Enter username: ", 
                  controller: TextEditingController(text: widget.userName),
                  onTextEntered: (s) {widget.userName = s; setState((){});}),
                },
              ),
              SettingsTile(
                title: const Text(
                  'Height',
                  style: TextStyle(
                    fontSize: 25.0,
                  )
                ),
                trailing: Text(
                  widget.height.toString(),
                  style: const TextStyle(
                    fontSize: 25.0,
                  )
                ),
                onPressed: (context) => {
                  _displayIntInputDialog(context, 
                  title: "Enter height: ", 
                  controller: TextEditingController(text: widget.height.toString()),
                  onIntEntered: (val) {widget.height = val; setState((){});}
                  ),
                },
              ),
              SettingsTile(
                title: const Text(
                  'Weight',
                  style: TextStyle(
                    fontSize: 25.0,
                  )
                ),
                trailing: Text(
                  widget.weight.toString(),
                  style: const TextStyle(
                    fontSize: 25.0,
                  )
                ),
                onPressed: (context) => {
                  _displayIntInputDialog(context, 
                  title: "Enter weight: ", 
                  controller: TextEditingController(text: widget.weight.toString()),
                  onIntEntered: (val) {widget.weight = val; setState((){});}
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

class CaloriesGoalSettingsPage extends StatefulWidget {
  CaloriesGoalSettingsPage({super.key, required this.title});
  final String title;
  @override
  State<CaloriesGoalSettingsPage> createState() => _CaloriesGoalSettingsPageState();
  int targetWeight = 55;
  bool isRecommendedSettings = true;
}

class _CaloriesGoalSettingsPageState extends State<CaloriesGoalSettingsPage> with InputDialog {
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
                title: const Text(
                  'Target Weight',
                  style: TextStyle(
                    fontSize: 25.0,
                  )
                ),
                trailing: Text(
                  widget.targetWeight.toString(),
                  style: const TextStyle(
                    fontSize: 25.0,
                  )
                ),
                onPressed: (context) => {
                  _displayIntInputDialog(context, 
                  title: "Enter username: ", 
                  controller: TextEditingController(text: widget.targetWeight.toString()),
                  onIntEntered: (s) {widget.targetWeight = s; setState((){});}),
                },
              ),
              SettingsTile.switchTile(
                initialValue: widget.isRecommendedSettings,
                onToggle: (value) {
                  widget.isRecommendedSettings = value;
                  setState((){});
                },
                title: const Text("Recommended Settings")
              ),
            ],
          ),
        ],
      ),
    );
  }
}