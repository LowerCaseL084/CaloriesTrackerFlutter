import 'package:calories_tracker/camera/model/mask.dart';
import 'package:calories_tracker/constants.dart';

enum CalorieTable
{
  apple(95.0, 182, [CaloriesAllergy.apples]),
  lemon(17.0, 58, []),
  banana(111, 125, []),
  strawberry(3.87, 12, []),
  watermelon(28600.0, 9000, []);

  const CalorieTable(this.calories, this.averageWeight, this.allergies);

  final double calories;
  final double averageWeight;
  final List<CaloriesAllergy> allergies;

  static const Map<String, CalorieTable> get = {
    "Apple":CalorieTable.apple,
    "Strawberry":CalorieTable.strawberry,
    "Banana":CalorieTable.banana,
    "Watermelon":CalorieTable.watermelon,
    "Lemon":CalorieTable.lemon,
  };
}

class Calorie
{
  static double getCalories(Mask mask, int index)
  {
    return CalorieTable.get[mask.labels[index]]?.calories ?? 0.0;
  }

  static List<CaloriesAllergy> getAllergies(Mask mask, int index)
    => CalorieTable.get[mask.labels[index]]?.allergies ?? [];

  static List<CaloriesAllergy> getAllAllergies(Mask mask)
  {
    return List.generate(mask.labels.length, (i) => getAllergies(mask, i)).expand<CaloriesAllergy>((e) => e).toList();
  }
}