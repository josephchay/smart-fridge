class SelectedFilterListData {
  SelectedFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<SelectedFilterListData> categoryTypes = <SelectedFilterListData>[
    SelectedFilterListData(
      titleTxt: 'Milk',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Cheese',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Eggs',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Chocolate',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Drink Mixes',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Beverage Deals',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Meat Sticks',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Yeast',
      isSelected: false,
    ),
  ];

  static List<SelectedFilterListData> brandTypes = <SelectedFilterListData>[
    SelectedFilterListData(
      titleTxt: 'Marketside',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Price\'s',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Julio\'s',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Rojo\'s',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Marzetti',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Pace',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Yucatan',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Monster Energy',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Skippy',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Celsius',
      isSelected: false,
    ),
    SelectedFilterListData(
      titleTxt: 'Pompeian',
      isSelected: false,
    ),
  ];
}
