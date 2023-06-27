import 'package:flutter/material.dart';

@immutable
class FoodEntry
{
  FoodEntry({required String name, required double calories}):
    nameController = TextEditingController(text: name),
    caloriesController = TextEditingController(text: calories.toString());

  final TextEditingController nameController;
  final TextEditingController caloriesController;
}