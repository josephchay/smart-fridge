class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/images/temp/chicken-rice.jpg',
      title: 'Chicken Rice',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/images/temp/wantan-mee.jpg',
      title: 'Wanton Mee Noodles',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
    Category(
      imagePath: 'assets/images/temp/curry-laksa.jpg',
      title: 'Curra Laksa',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/images/temp/chicken-chop.jpg',
      title: 'Chicken Chop',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/images/temp/spaghetti.jpg',
      title: 'Spaghetti Balognesse',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/temp/pizza.jpg',
      title: 'Pizza Aloha',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/images/temp/fish-chips.webp',
      title: 'Fish and Chips',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/temp/toast.jpg',
      title: 'Toast Bread',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
  ];
}
