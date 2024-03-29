enum CaloriesAllergy {
  milk(preferenceKey: 'allergy_lactose', text: 'Milk'),
  peanut(preferenceKey: 'allergy_peanut', text: 'Peanut'),
  egg(preferenceKey: 'allergy_egg', text: 'Egg'),
  fish(preferenceKey: 'allergy_fish', text: 'Fish'),
  soy(preferenceKey: 'allergy_soy', text: 'Soy'),
  celery(preferenceKey: 'allergy_celery', text: 'Celery'),
  gluten(preferenceKey: 'allergy_gluten', text: 'Gluten'),
  crustaceans(preferenceKey: 'allergy_crustaceans', text: 'Crustaceans'),
  treenuts(preferenceKey: 'allergy_treenuts', text: 'Treenuts'),
  apples(preferenceKey: 'allergy_apples', text: "Apples");

  const CaloriesAllergy({
    required this.preferenceKey,
    required this.text,
  });

  final String preferenceKey;
  final String text;
}

enum Gender {
  none,
  male,
  female,
}

const String apiUrl = 'http://10.0.2.2:50891/';