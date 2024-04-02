class Meal {
  Meal({
    required this.title,
    required this.image,
    required this.duration,
    required this.stepsCount,
    this.isFavourite = false,
  });

  String title;
  String image;
  String duration;
  int stepsCount;
  bool isFavourite;
}

final List<Meal> recommendedMealList = <Meal>[
  Meal(
    image: 'assets/images/meals/beef_bibimbap_recipe.jpeg',
    title: 'Beef Bibimbap',
    duration: '1h 30m',
    stepsCount: 6,
  ),
  Meal(
    image: 'assets/images/meals/crispy_honey_ginger_salmon_bowl.png',
    title: 'Crispy Honey Ginger Salmon Bowl',
    duration: '2h 12m',
    stepsCount: 18,
  ),
  Meal(
    image: 'assets/images/meals/grilled_thai_red_curry_shrimp.jpeg',
    title: 'Grilled Thai Red Curry Shrimp',
    duration: '20m',
    stepsCount: 25,
  ),
  Meal(
    image: 'assets/images/meals/muschel_spaghetti_in_tomatensugo.jpeg',
    title: 'Muschel Spaghetti in Tomatensugo',
    duration: '5m',
    stepsCount: 18,
  ),
];

final List<Meal> trendingMealList = <Meal>[
  Meal(
    image: 'assets/images/meals/ramen_noodles.jpg',
    title: 'Ramen Noodles',
    duration: '1h 30m',
    stepsCount: 25,
  ),
  Meal(
    image: 'assets/images/meals/shrimp_sushi_bowls.jpeg',
    title: 'Shrimp Sushi Bowls',
    duration: '1h 12m',
    stepsCount: 4,
    isFavourite: true,
  ),
  Meal(
    image: 'assets/images/meals/grilled_chicken_salad.jpeg',
    title: 'Grilled Chicken Salad',
    duration: '20m',
    stepsCount: 25,
    isFavourite: true,
  ),
  Meal(
    image: 'assets/images/meals/dumplings.jpg',
    title: 'Dumplings',
    duration: '7m',
    stepsCount: 20,
  ),
];
