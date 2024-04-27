class CurrentDietsListData {
  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kcal;

  CurrentDietsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kcal = 0,
  });

  static List<CurrentDietsListData> tabIconsList = <CurrentDietsListData>[
    CurrentDietsListData(
      // imagePath: 'assets/images/breakfast.png',
      imagePath: 'assets/images/icons/egg-fried.svg',
      titleTxt: 'Breakfast',
      kcal: 0,
      meals: <String>[],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    CurrentDietsListData(
      imagePath: 'assets/images/icons/bowl-chopsticks-noodles.svg',
      titleTxt: 'Lunch',
      kcal: 567,
      meals: <String>[],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    CurrentDietsListData(
      imagePath: 'assets/images/icons/mug-saucer.svg',
      titleTxt: 'Tea',
      kcal: -1,
      meals: <String>[],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    CurrentDietsListData(
      imagePath: 'assets/images/icons/turkey.svg',
      titleTxt: 'Dinner',
      kcal: -1,
      meals: <String>[],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
