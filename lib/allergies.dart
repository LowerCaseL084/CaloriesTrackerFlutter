enum CaloriesAllergy {
  lactose(preferenceKey: 'allergy_lactose', text: 'Lactose'),
  peanut(preferenceKey: 'allergy_peanut', text: 'Peanut'),
  treenut(preferenceKey: 'treenut', text: 'Treenut'),
  milk(preferenceKey: 'milk', text: 'Milk'),
  egg(preferenceKey: 'egg', text: 'Egg');

  const CaloriesAllergy({
    required this.preferenceKey,
    required this.text,
  });

  final String preferenceKey;
  final String text;
}
