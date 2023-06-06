import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:calories_tracker/components/dialog_box.dart';
import 'package:calories_tracker/settings/controller/settings_controller.dart';
import 'package:calories_tracker/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// User settings page

class CaloriesUserSettingsPage extends ConsumerWidget {
  const CaloriesUserSettingsPage({super.key, required this.title});
  final String title;

  static const genderMap = {
    Gender.male : 'Male',
    Gender.female :'Female',
    Gender.none : "Other"
  };

 /* @override
  State<CaloriesUserSettingsPage> createState() =>
      _CaloriesUserSettingsPageState();
}

class _CaloriesUserSettingsPageState extends State<CaloriesUserSettingsPage> {*/

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncSettings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: asyncSettings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stackTrace) {
          developer.log("$err, $stackTrace", name: 'calories_app.settings.application_settings');
          return const Text("Error loading settings!");
        },
        data: (settings) {
          return Center(
            //mainAxisAlignment: MainAxisAlignment.center,
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Name',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                  trailing: Text(settings.userName,
                      style: const TextStyle(
                        fontSize: 25.0,
                      )),
                  onTap: () => {
                    InputDialog.displayTextInputDialog(context,
                        title: "Enter username: ",
                        controller: TextEditingController(text: settings.userName),
                        onTextEntered: (s) {
                          ref.read(settingsNotifier.notifier).set(userName: s);
                    }),
                  },
                ),
                ListTile(
                  title: const Text('Height',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                  trailing: Text(settings.height.toString(),
                      style: const TextStyle(
                        fontSize: 25.0,
                      )),
                  onTap: () => {
                    InputDialog.displayIntInputDialog(context,
                        title: "Enter height: ",
                        controller: TextEditingController(text: settings.height.toString()),
                        onIntEntered: (val) {
                          ref.read(settingsNotifier.notifier).set(height: val);
                    }),
                  },
                ),
                ListTile(
                  title: const Text('Weight',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                  trailing: Text(settings.weight.toString(),
                      style: const TextStyle(
                        fontSize: 25.0,
                      )),
                  onTap: () => {
                    InputDialog.displayIntInputDialog(context,
                        title: "Enter weight: ",
                        controller: TextEditingController(text: settings.weight.toString()),
                        onIntEntered: (val) {
                          ref.read(settingsNotifier.notifier).set(weight: val);
                    }),
                  },
                ),
                ListTile(
                  title: const Text(
                    'Age',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  trailing: Text(
                    settings.age.toString(),
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  onTap: () {
                    InputDialog.displayIntInputDialog(context,
                        title: "Enter age: ",
                        controller: TextEditingController(text: settings.age.toString()),
                        onIntEntered: (ag) {
                          ref.read(settingsNotifier.notifier).set(age: ag);
                    });
                  },
                ),
                ListTile(
                  title: const Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  trailing: DropdownMenu<Gender>(
                    dropdownMenuEntries: Gender.values.map((e) => DropdownMenuEntry<Gender>(value: e, label: genderMap[e] ?? 'Other')).toList(),
                    width: null,
                    initialSelection: settings.gender,
                    onSelected: (s) {
                      ref.read(settingsNotifier.notifier).set(gender: s);
                    },
                  )
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}