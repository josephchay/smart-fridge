import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_fridge/grocery_listings/model/grocery_data.dart';

import '../src/config/themes/app_theme.dart';
import 'model/popular_filter_list.dart';
import 'range_slider_view.dart';
import 'slider_view.dart';

class FiltersScreen extends StatefulWidget {
  final Function(List<GroceryData>) updateFilteredDataCallback;

  const FiltersScreen({
    super.key,
    required this.updateFilteredDataCallback,
  });

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  RangeValues _values = const RangeValues(100, 600);
  double distValue = 50.0;

  void applyFilters() {
    Set<String> selectedCategories = SelectedFilterListData.categoryTypes
        .where((item) => item.isSelected)
        .map((item) => item.titleTxt)
        .toSet();

    Set<String> selectedBrands = SelectedFilterListData.brandTypes
        .where((item) => item.isSelected)
        .map((item) => item.titleTxt)
        .toSet();

    List<GroceryData> newFilteredData = groceryList.where((grocery) {
      bool categoryMatch = selectedCategories.isEmpty ||
          selectedCategories.contains(grocery.category);
      bool brandMatch =
          selectedBrands.isEmpty || selectedBrands.contains(grocery.brand);
      double price = double.tryParse(grocery.price) ??
          0; // Safely convert price to double, default to 0 if conversion fails
      bool priceMatch = (price >= _values.start && price <= _values.end);

      return categoryMatch && brandMatch && priceMatch;
    }).toList();

    widget.updateFilteredDataCallback(newFilteredData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.buildLightTheme().backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    priceBarFilter(),
                    const Divider(
                      height: 1,
                    ),
                    foodTypeFilter("category"),
                    const Divider(
                      height: 1,
                    ),
                    foodTypeFilter("brand"),
                    const Divider(
                      height: 1,
                    ),
                    allAccommodationUI()
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.buildLightTheme().primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      applyFilters();
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Apply',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Padding(
        //   padding:
        //       const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        //   child: Text(
        //     'Type of Accommodation',
        //     textAlign: TextAlign.left,
        //     style: TextStyle(
        //         color: Colors.grey,
        //         fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
        //         fontWeight: FontWeight.normal),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
              // children: getAccomodationListUI(),
              ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget foodTypeFilter(String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            '${type.capitalize} types',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getPList(type),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getPList(String type) {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;

    List<SelectedFilterListData> edibleTypesFilterListData = type == "category"
        ? SelectedFilterListData.categoryTypes
        : SelectedFilterListData.brandTypes;

    for (int i = 0; i < edibleTypesFilterListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final SelectedFilterListData type = edibleTypesFilterListData[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        type.isSelected = !type.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            type.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: type.isSelected
                                ? AppTheme.buildLightTheme().primaryColor
                                : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            type.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < edibleTypesFilterListData.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget priceBarFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Price Range',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        RangeSliderView(
          values: _values,
          onChangeRangeValues: (RangeValues values) {
            setState(() {
              _values = values;
            });
          },
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Filters',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
