import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

mixin InputDialog {
  // From Harsh Pipaliya
  // https://stackoverflow.com/questions/49778217/how-to-create-a-dialog-that-is-able-to-accept-text-input-and-show-result-in-flut

  Future<void> _displayTextInputDialog(BuildContext context,
      {String title = '',
      required TextEditingController controller,
      required void Function(String) onTextEntered}) async {
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

  Future<void> _displayIntInputDialog(BuildContext context,
      {String title = '',
      required TextEditingController controller,
      required void Function(int) onIntEntered}) async {
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
                if (val == null) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Invalid input"),
                          content: Text("Enter valid integer!"),
                        );
                      });
                } else {
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
      backgroundColor: const Color(0xFF070A52),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF00337C),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'User Information',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
              onTap: () {
                Navigator.pushNamed(context, '/settings/user_settings');
              },
            ),
            ListTile(
              title: const Text(
                'Goal Settings',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
              onTap: () {
                Navigator.pushNamed(context, '/settings/goal_settings');
              },
            ),
            ListTile(
              title: const Text(
                'Allergies',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
              // onTap: () {
              //   Navigator.pushNamed(context, '/');
              // },
            ),
            ListTile(
              title: const Text(
                'Application Settings',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
              // onTap: () {
              //   Navigator.pushNamed(context, '/');
              // },
            ),
          ],
        ),
      ),
    );
  }
}

class CaloriesUserSettingsPage extends StatefulWidget {
  CaloriesUserSettingsPage({super.key, required this.title});
  final String title;
  String userName = '--'; // = permenet variable for storing username
  int height = 00; // = permenet variable for storing height
  int weight = 00; // = permenet variable for storing weight
  int age = 00;
  String gender = '----';
  var items = [
    '----',
    'Male',
    'Female',
  ];
  @override
  State<CaloriesUserSettingsPage> createState() =>
      _CaloriesUserSettingsPageState();
}

class _CaloriesUserSettingsPageState extends State<CaloriesUserSettingsPage>
    with InputDialog {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070A52),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF00337C),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Name',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
              trailing: Text(
                widget.userName,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                _displayTextInputDialog(context,
                    controller: TextEditingController(text: widget.userName),
                    onTextEntered: (s) {
                  widget.userName = s;
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text(
                'Height',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
              trailing: Text(
                widget.height.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                _displayIntInputDialog(context,
                    controller:
                        TextEditingController(text: widget.height.toString()),
                    onIntEntered: (n) {
                  widget.height = n;
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text(
                'Weight',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
              trailing: Text(
                widget.weight.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                _displayIntInputDialog(context,
                    controller:
                        TextEditingController(text: widget.weight.toString()),
                    onIntEntered: (m) {
                  widget.weight = m;
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text(
                'Age',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
              trailing: Text(
                widget.age.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                _displayIntInputDialog(context,
                    controller:
                        TextEditingController(text: widget.age.toString()),
                    onIntEntered: (ag) {
                  widget.age = ag;
                  setState(() {});
                });
              },
            ),
            const ListTile(
              title: Text(
                'Gender',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
            ),
            Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: DropdownButton(
                  value: widget.gender,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: widget.items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          items,
                          style: const TextStyle(color: Color(0xFF2ABE8E)),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.gender = newValue!;
                    });
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class CaloriesGoalSettingsPage extends StatefulWidget {
  CaloriesGoalSettingsPage({super.key, required this.title});
  final String title;
  @override
  State<CaloriesGoalSettingsPage> createState() =>
      _CaloriesGoalSettingsPageState();
  int targetWeight = 00;
  bool isRecommendedSettings = true;
}

class _CaloriesGoalSettingsPageState extends State<CaloriesGoalSettingsPage>
    with InputDialog {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070A52),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF00337C),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Target Weight',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              textColor: Color(0xFFFFFFFF),
              onTap: () {
                Navigator.pushNamed(context, '/settings/user_settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}
