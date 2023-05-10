enum CaloriesAllergy{
  lactose(preferenceKey:'allergy_lactose', text: 'Lactose'),
  peanut(preferenceKey:'allergy_peanut', text:'Peanut');

  const CaloriesAllergy({
    required this.preferenceKey,
    required this.text,
  });

  final String preferenceKey;
  final String text;
}