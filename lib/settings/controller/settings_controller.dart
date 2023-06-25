import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calories_tracker/settings/model/settings_model.dart';
import 'package:calories_tracker/constants.dart';

final settingsNotifier =
    AsyncNotifierProvider.autoDispose<SettingsNotifier, CaloriesAppSettings>(() {
  return SettingsNotifier();
});

class SettingsNotifier extends AutoDisposeAsyncNotifier<CaloriesAppSettings> {
  @override
  Future<CaloriesAppSettings> build() {
    ref.onDispose(() {
      saveSettings();
    });
    return CaloriesAppSettings.loadSettings();
  }

  Future<void> set(
      {String? userName,
      int? height,
      int? weight,
      int? age,
      Gender? gender,
      bool? manualInputMode,
      ThemeMode? theme,
      int? targetWeight,
      double? targetCalories,
      bool? isRecommendedSettings,
      bool? isCaloriesLessThan,
      Map<CaloriesAllergy, bool>? allergies}) async {
    state.whenData((val) {
      state = AsyncValue.data(CaloriesAppSettings(
        userName: userName ?? val.userName,
        height: height ?? val.height,
        weight: weight ?? val.weight,
        age: age ?? val.age,
        gender: gender ?? val.gender,
        manualInputMode: manualInputMode ?? val.manualInputMode,
        theme: theme ?? val.theme,
        targetWeight: targetWeight ?? val.targetWeight,
        targetCalories: targetCalories ?? val.targetCalories,
        isRecommendedSettings:
            isRecommendedSettings ?? val.isRecommendedSettings,
        isCaloriesLessThan: isCaloriesLessThan ?? val.isCaloriesLessThan,
        allergies: allergies ?? val.allergies,
      ));
    });
    saveSettings();
  }

  Future<void> saveSettings() async {
    await state.value?.saveSettings();
  }
}
