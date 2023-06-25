import 'package:calories_tracker/camera/model/mask.dart';

enum CalorieTable
{
  apple(95.0, 182),
  lemon(17.0, 58),
  banana(111, 125),
  strawberry(3.87, 12),
  watermelon(28600.0, 9000);

  const CalorieTable(this.calories, this.averageWeight);

  final double calories;
  final double averageWeight;
}

class Calorie
{
  static double getCalories(Mask mask, int index)
  {
    switch(mask.labels[index])
    {
      case "Apple":
        return CalorieTable.apple.calories;
      case "Strawberry":
        return CalorieTable.strawberry.calories;
      case "Watermelon":
        return CalorieTable.watermelon.calories;
      case "Banana":
        return CalorieTable.banana.calories;
      case "Lemon":
        return CalorieTable.lemon.calories;
    }
    return 0.0;
  }
}