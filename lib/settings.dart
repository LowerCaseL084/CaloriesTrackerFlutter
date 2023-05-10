import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calories_tracker/allergies.dart';

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
            title: const Text(
              'User Information',
              style: TextStyle(
                fontSize: 25.0,
              )
            ),
            onTap: () => {Navigator.pushNamed(context, '/settings/user_settings')},
          ),
          ListTile(
            title: const Text(
              'Goal Settings',
              style: TextStyle(
                fontSize: 25.0,
              )
            ),
            onTap: () => {Navigator.pushNamed(context, '/settings/goal_settings')},
          ),
          ListTile(
            title: const Text(
              'Allergies',
              style: TextStyle(
                fontSize: 25.0,
              )
            ),
            onTap: () => {Navigator.pushNamed(context, '/settings/allergies_list')},
          ),
          ListTile(
            title: const Text(
              'Application Settings',
              style: TextStyle(
                fontSize: 25.0,
              )
            ),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}

// User settings page

class CaloriesUserSettingsPage extends StatefulWidget {
  const CaloriesUserSettingsPage({super.key, required this.title});
  final String title;
  @override
  State<CaloriesUserSettingsPage> createState() => _CaloriesUserSettingsPageState();
}

class _CaloriesUserSettingsPageState extends State<CaloriesUserSettingsPage> with InputDialog {

  String _userName='';
  int _height=0;
  int _weight=0;

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = (prefs.getString('user_name') ?? '');
      _height = (prefs.getInt('height') ?? 0);
      _weight = (prefs.getInt('weight') ?? 0);
    });
  }

  Future<void> _updateValues() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', _userName);
    prefs.setInt('height', _height);
    prefs.setInt('weight', _weight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          ListTile(
            title: const Text(
              'Name',
              style: TextStyle(
                fontSize: 25.0,
              )
            ),
            trailing: Text(
              _userName,
              style: const TextStyle(
                fontSize: 25.0,
              )
            ),
            onTap: () => {
              _displayTextInputDialog(context, 
              title: "Enter username: ", 
              controller: TextEditingController(text: _userName),
              onTextEntered: (s) {_userName = s; _updateValues(); setState((){});}),
            },
          ),
          ListTile(
            title: const Text(
              'Height',
              style: TextStyle(
                fontSize: 25.0,
              )
            ),
            trailing: Text(
              _height.toString(),
              style: const TextStyle(
                fontSize: 25.0,
              )
            ),
            onTap: () => {
              _displayIntInputDialog(context, 
              title: "Enter height: ", 
              controller: TextEditingController(text: _height.toString()),
              onIntEntered: (val) {_height = val; _updateValues(); setState((){});}
              ),
            },
          ),
          ListTile(
            title: const Text(
              'Weight',
              style: TextStyle(
                fontSize: 25.0,
              )
            ),
            trailing: Text(
              _weight.toString(),
              style: const TextStyle(
                fontSize: 25.0,
              )
            ),
            onTap: () => {
              _displayIntInputDialog(context, 
              title: "Enter weight: ", 
              controller: TextEditingController(text: _weight.toString()),
              onIntEntered: (val) {_weight = val; _updateValues(); setState((){});}
              ),
            },
          ),
        ],
      ),
    );
  }
}

// Goal settings page

class CaloriesGoalSettingsPage extends StatefulWidget {
  const CaloriesGoalSettingsPage({super.key, required this.title});
  final String title;
  @override
  State<CaloriesGoalSettingsPage> createState() => _CaloriesGoalSettingsPageState();
}

class _CaloriesGoalSettingsPageState extends State<CaloriesGoalSettingsPage> with InputDialog {
  int _targetWeight = 0;
  bool _isRecommendedSettings = true;

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isRecommendedSettings = (prefs.getBool('recommended_settings') ?? true);
      _targetWeight = (prefs.getInt('target_weight') ?? 0);
    });
  }

  Future<void> _updateValues() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('recommended_settings', _isRecommendedSettings);
    prefs.setInt('target_weight', _targetWeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: const Text(
              'Target Weight',
              style: TextStyle(
                fontSize: 25.0,
              )
            ),
            trailing: Text(
              _targetWeight.toString(),
              style: const TextStyle(
                fontSize: 25.0,
              )
            ),
            onTap: () => {
              _displayIntInputDialog(context, 
              title: "Enter username: ", 
              controller: TextEditingController(text: _targetWeight.toString()),
              onIntEntered: (s) {_targetWeight = s; _updateValues(); setState((){});}),
            },
          ),
          ListTile(
            title: const Text("Recommended Settings"),
            trailing: Switch(
              value: _isRecommendedSettings,
              onChanged: (value) {
                _isRecommendedSettings = value;
                _updateValues();
                setState((){});
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Allergies list

class CaloriesAllergiesListPage extends StatefulWidget {
  const CaloriesAllergiesListPage({super.key, required this.title});
  final String title;
  @override
  State<CaloriesAllergiesListPage> createState() => _CaloriesAllergiesListPageState();
}

class _CaloriesAllergiesListPageState extends State<CaloriesAllergiesListPage> {
  final Map<CaloriesAllergy,bool> _allergies = { for (var i in CaloriesAllergy.values) i:false };

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for(var i in CaloriesAllergy.values)
      {
        _allergies[i] = (prefs.getBool(i.preferenceKey) ?? false);
      }
    });
  }

  Future<void> _updateValues() async {
    final prefs = await SharedPreferences.getInstance();
    for(var i in CaloriesAllergy.values)
    {
      prefs.setBool(i.preferenceKey, _allergies[i] ?? false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var i in CaloriesAllergy.values)
            ListTile(
              title: Text(i.text),
              trailing: Checkbox(
                value: _allergies[i],
                onChanged: (bool? value) {
                  _allergies[i] = value ?? false;
                  _updateValues();
                  setState(() {});
                },
              ),
            ),
        ],
      ),
    );
  }
}