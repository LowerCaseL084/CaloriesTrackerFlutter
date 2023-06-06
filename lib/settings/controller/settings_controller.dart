import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calories_tracker/settings/model/settings_model.dart';
import 'package:calories_tracker/constants.dart';

final settingsNotifier = AsyncNotifierProvider<SettingsNotifier,CaloriesAppSettings>(
  () {
    var notifier = SettingsNotifier();
    //notifier.ref.onDispose(() { notifier.saveSettings(); });
    return notifier;
  }
);

final settingsProvider = Provider.autoDispose<AsyncValue<CaloriesAppSettings>>((ref) { return ref.watch(settingsNotifier); });

class SettingsNotifier extends AsyncNotifier<CaloriesAppSettings>
{
  @override
  Future<CaloriesAppSettings> build()
  {
    return CaloriesAppSettings.loadSettings();
  }

  Future<void> set({String? userName, int? height, int? weight, int? age, Gender? gender, bool? manualInputMode,
      ThemeMode? theme, int? targetWeight, bool? isRecommendedSettings, Map<CaloriesAllergy, bool>? allergies}) async
  {
    state.whenData(
      (val) {
        state = AsyncValue.data(
          CaloriesAppSettings(
            userName: userName ?? val.userName,
            height: height ?? val.height,
            weight: weight ?? val.weight,
            age: age ?? val.age,
            gender: gender ?? val.gender,
            manualInputMode: manualInputMode ?? val.manualInputMode,
            theme: theme ?? val.theme,
            targetWeight: targetWeight ?? val.targetWeight,
            isRecommendedSettings: isRecommendedSettings ?? val.isRecommendedSettings,
            allergies: allergies ?? val.allergies,
          )
        );
      }
    );
  }

  Future<void> saveSettings() async
  {
    await state.value?.saveSettings();
  }
}