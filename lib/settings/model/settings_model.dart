import 'package:calories_tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaloriesAppSettings {
  CaloriesAppSettings(
      {required this.userName,
      required this.height,
      required this.weight,
      required this.age,
      required this.gender,
      required this.manualInputMode,
      required this.theme,
      required this.targetWeight,
      required this.targetCalories,
      required this.isRecommendedSettings,
      required this.isCaloriesLessThan,
      required this.allergies});

  late String userName;
  late int height;
  late int weight;
  late int age;
  late Gender gender;
  late bool manualInputMode;
  late ThemeMode theme;
  late int targetWeight;
  late double targetCalories;
  late bool isCaloriesLessThan;
  late bool isRecommendedSettings;
  late Map<CaloriesAllergy, bool> allergies;

  static Future<CaloriesAppSettings> loadSettings() async {
    String userName;
    int height;
    int weight;
    int age;
    Gender gender;
    bool manualInputMode;
    ThemeMode theme;
    int targetWeight;
    double targetCalories;
    bool isCaloriesLessThan;
    bool isRecommendedSettings;
    Map<CaloriesAllergy, bool> allergies = {};

    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();

    for (var i in CaloriesAllergy.values) {
      allergies[i] = (prefs.getBool(i.preferenceKey) ?? false);
    }
    manualInputMode = (prefs.getBool('manual_input') ?? true);
    var strtheme = (prefs.getString('theme') ?? 'system');
    theme = strtheme == 'light'
        ? ThemeMode.light
        : (strtheme == 'dark' ? ThemeMode.dark : ThemeMode.system);

    userName = (prefs.getString('user_name') ?? '');
    height = (prefs.getInt('height') ?? 0);
    weight = (prefs.getInt('weight') ?? 0);
    age = (prefs.getInt('age') ?? 0);
    var strgender = (prefs.getString('gender') ?? '');
    gender = strgender == 'male'
        ? Gender.male
        : (strgender == 'female' ? Gender.female : Gender.none);

    isRecommendedSettings = (prefs.getBool('recommended_settings') ?? true);
    isCaloriesLessThan = (prefs.getBool('calories_less_than') ?? true);
    targetWeight = (prefs.getInt('target_weight') ?? 0);
    targetCalories = (prefs.getDouble('target_calories') ?? 0.0);

    return CaloriesAppSettings(
        userName: userName,
        height: height,
        weight: weight,
        age: age,
        gender: gender,
        manualInputMode: manualInputMode,
        theme: theme,
        targetWeight: targetWeight,
        targetCalories: targetCalories,
        isCaloriesLessThan: isCaloriesLessThan,
        isRecommendedSettings: isRecommendedSettings,
        allergies: allergies);
  }

  Future<void> saveSettings() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('manual_input', manualInputMode);

    var strtheme = theme == ThemeMode.light
        ? 'light'
        : (theme == ThemeMode.dark ? 'dark' : 'system');
    await prefs.setString('theme', strtheme);

    await prefs.setString('user_name', userName);
    await prefs.setInt('height', height);
    await prefs.setInt('weight', weight);
    await prefs.setInt('age', age);

    var strgender = gender == Gender.male
        ? 'male'
        : (gender == Gender.female ? 'female' : 'none');
    await prefs.setString('gender', strgender);

    await prefs.setBool('recommended_settings', isRecommendedSettings);
    await prefs.setBool('calories_less_than', isCaloriesLessThan);
    await prefs.setInt('target_weight', targetWeight);
    await prefs.setDouble('target_calories', targetCalories);

    for (var i in CaloriesAllergy.values) {
      await prefs.setBool(i.preferenceKey, allergies[i] ?? false);
    }
  }
}
