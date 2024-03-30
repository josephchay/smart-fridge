class EdibleTypesFilterListData {
  EdibleTypesFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<EdibleTypesFilterListData> meatTypes =
      <EdibleTypesFilterListData>[
    EdibleTypesFilterListData(
      titleTxt: 'Poultry',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Beef',
      isSelected: true,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Pork',
      isSelected: true,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Lamb',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Veal',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Seafood',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Processed Meat',
      isSelected: false,
    ),
  ];

  static List<EdibleTypesFilterListData> vegeTypes =
      <EdibleTypesFilterListData>[
    EdibleTypesFilterListData(
      titleTxt: 'Leafy Greens',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Cruciferous',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Root Vegetables',
      isSelected: true,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Squashes',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Nightshades',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Alliums',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Legumes',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Fungi',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Cucurbits',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Edible Flowers',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Herbs',
      isSelected: false,
    ),
  ];

  static List<EdibleTypesFilterListData> accomodationList = [
    EdibleTypesFilterListData(
      titleTxt: 'All',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Apartment',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Home',
      isSelected: true,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Villa',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Hotel',
      isSelected: false,
    ),
    EdibleTypesFilterListData(
      titleTxt: 'Resort',
      isSelected: false,
    ),
  ];
}
