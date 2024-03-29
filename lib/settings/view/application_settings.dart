import 'dart:developer' as developer;
import 'package:calories_tracker/data/controller.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/settings/controller/settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calories_tracker/theme/theme_change_provider.dart';

// Application settings page

class CaloriesApplicationSettingsPage extends ConsumerStatefulWidget {
  const CaloriesApplicationSettingsPage({super.key, required this.title});
  final String title;
  @override
  ConsumerState<CaloriesApplicationSettingsPage> createState() =>
      _CaloriesApplicationSettingsPageState();
}

class _CaloriesApplicationSettingsPageState
    extends ConsumerState<CaloriesApplicationSettingsPage> {
  bool cleared = false;
  @override
  Widget build(BuildContext context) {
    var asyncSettings = ref.watch(settingsNotifier);
    ref.watch(dataStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: asyncSettings.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stackTrace) {
            developer.log("$err",
                name: 'calories_app.settings.application_settings');
            return const Text("Error loading settings!");
          },
          data: (settings) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: const Text("Manual Input Mode"),
                  trailing: Switch(
                    value: settings.manualInputMode,
                    onChanged: (value) {
                      ref
                          .read(settingsNotifier.notifier)
                          .set(manualInputMode: value);
                    },
                  ),
                ),
                ListTile(
                    title: const Text("Theme"),
                    trailing: DropdownMenu<String>(
                      dropdownMenuEntries: ['System Default', 'Light', 'Dark']
                          .map((e) =>
                              DropdownMenuEntry<String>(value: e, label: e))
                          .toList(),
                      width: null,
                      initialSelection: settings.theme == ThemeMode.light
                          ? 'Light'
                          : (settings.theme == ThemeMode.dark
                              ? 'Dark'
                              : 'System Default'),
                      onSelected: (s) {
                        if (s == 'Light') {
                          ref
                              .read(settingsNotifier.notifier)
                              .set(theme: ThemeMode.light);
                          ref
                              .read(themeChangeNotifierProvider.notifier)
                              .changeTheme(ThemeMode.light);
                        } else if (s == 'Dark') {
                          ref
                              .read(settingsNotifier.notifier)
                              .set(theme: ThemeMode.dark);
                          ref
                              .read(themeChangeNotifierProvider.notifier)
                              .changeTheme(ThemeMode.dark);
                        } else {
                          ref
                              .read(settingsNotifier.notifier)
                              .set(theme: ThemeMode.system);
                          ref
                              .read(themeChangeNotifierProvider.notifier)
                              .changeTheme(ThemeMode.system);
                        }
                      },
                    )),
                ListTile(
                  title: GestureDetector(
                    child: Text(cleared?"Data cleared!":"Clear Data"),
                    onTap: () async {
                      await ref.read(dataStateProvider.notifier).clear();
                      setState(() {
                        cleared = true;
                      });
                    },
                  ),
                ),
                const ListTile(
                  title: Text("Developer Info"),
                ),
              ],
            );
          }),
    );
  }
}
