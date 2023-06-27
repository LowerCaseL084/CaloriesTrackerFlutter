import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:calories_tracker/settings/controller/settings_controller.dart';
import 'package:calories_tracker/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Allergies list

class CaloriesAllergiesListPage extends ConsumerWidget {
  const CaloriesAllergiesListPage({super.key, required this.title});
  final String title;
  /*@override
  State<CaloriesAllergiesListPage> createState() =>
      _CaloriesAllergiesListPageState();
}

class _CaloriesAllergiesListPageState extends State<CaloriesAllergiesListPage> {*/

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
              for (var i in CaloriesAllergy.values)
                ListTile(
                  title: Text(i.text),
                  trailing: Checkbox(
                    value: settings.allergies[i],
                    onChanged: (bool? value) {
                      var allergies = settings.allergies;
                      allergies[i] = value ?? false;
                      ref.read(settingsNotifier.notifier).set(allergies: allergies);
                    },
                  ),
                ),
            ],
          );
        }
      ),
    );
  }
}
