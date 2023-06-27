import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:calories_tracker/components/dialog_box.dart';
import 'package:calories_tracker/settings/controller/settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Goal settings page

class CaloriesGoalSettingsPage extends ConsumerWidget {
  const CaloriesGoalSettingsPage({super.key, required this.title});
  final String title;
  /*
  @override
  State<CaloriesGoalSettingsPage> createState() =>
      _CaloriesGoalSettingsPageState();
}

class _CaloriesGoalSettingsPageState extends State<CaloriesGoalSettingsPage> {*/

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncSettings = ref.watch(settingsNotifier);
    return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: asyncSettings.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stackTrace) {
        developer.log("$err", name: 'calories_app.settings.application_settings');
        return const Text("Error loading settings!");
      },
      data: (settings) {
        return Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: const Text("Recommended Settings"),
                trailing: Switch(
                  value: settings.isRecommendedSettings,
                  onChanged: (value) {
                    ref.read(settingsNotifier.notifier).set(isRecommendedSettings: value);
                  },
                ),
              ),
              if(settings.isRecommendedSettings)
                ListTile(
                  title: const Text('Target Weight',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                  trailing: Text(settings.targetWeight.toString(),
                      style: const TextStyle(
                        fontSize: 25.0,
                      )),
                  onTap: () => {
                    InputDialog.displayIntInputDialog(context,
                        title: "Enter weight: ",
                        controller:
                            TextEditingController(text: settings.targetWeight.toString()),
                        onIntEntered: (s) {
                          ref.read(settingsNotifier.notifier).set(targetWeight: s);
                    }),
                  },
                ),
              if(!settings.isRecommendedSettings)
                ListTile(
                  title: const Text('Target Calories',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                  trailing: Text(settings.targetCalories.toString(),
                      style: const TextStyle(
                        fontSize: 25.0,
                      )),
                  onTap: () => {
                    InputDialog.displayDoubleInputDialog(context,
                        title: "Enter calories: ",
                        controller:
                            TextEditingController(text: settings.targetCalories.toString()),
                        onIntEntered: (s) {
                          ref.read(settingsNotifier.notifier).set(targetCalories: s);
                    }),
                  },
                ),
              if(!settings.isRecommendedSettings)
                ListTile(
                  title: const Text("Target Mode",
                    style: TextStyle(
                      fontSize: 25.0,
                    )),
                  trailing: GestureDetector(
                    child: Text(settings.isCaloriesLessThan?"Maximum":"Minimum",
                    style: const TextStyle(
                      fontSize: 25.0,
                    )),
                    onTap: () {
                      ref.read(settingsNotifier.notifier).set(isCaloriesLessThan: !settings.isCaloriesLessThan);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}