class GroceryListData {
  GroceryListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.bought = 80,
    this.rating = 4.5,
    this.price = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int bought;
  int price;

  static List<GroceryListData> groceryList = <GroceryListData>[
    GroceryListData(
      imagePath: 'assets/images/temp/cabbage.webp',
      titleTxt: 'Cabbage',
      dist: 2.0,
      bought: 80,
      rating: 4.4,
      price: 4,
    ),
    GroceryListData(
      imagePath: 'assets/images/temp/onion.jpg',
      titleTxt: 'Onions',
      dist: 4.0,
      bought: 74,
      rating: 4.5,
      price: 2,
    ),
    GroceryListData(
      imagePath: 'assets/images/temp/pork.jpg',
      titleTxt: 'Pork',
      dist: 3.0,
      bought: 62,
      rating: 4.0,
      price: 60,
    ),
  ];
}
