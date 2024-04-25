import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_fridge/grocery_listings/grocery_list_view.dart';
import 'package:smart_fridge/grocery_listings/model/grocery_data.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'filters_screen.dart';

class GroceryScreen extends StatefulWidget {
  @override
  _GroceryScreenState createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();

  List<GroceryData> filteredGroceryData = [];

// print all the unique categories and brands
  void printUniqueCategoriesAndBrands() {
    print("Unique Categories:====================================");
    uniqueCategories.forEach((category) {
      print(category);
    });

    print("\nUnique Brands::====================================");
    uniqueBrands.forEach((brand) {
      print(brand);
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();

    filteredGroceryData = List.from(groceryList);
    // printUniqueCategoriesAndBrands();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  void updateFilteredData(List<GroceryData> newFilteredData) {
    setState(() {
      filteredGroceryData = newFilteredData;
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void onSearchChanged(String query) {
    // Ensure dupedFilteredGroceryData is a separate copy of the original full list
    // This should be done outside of this method to keep the original full list intact.
    List<GroceryData> dupedFilteredGroceryData = List.from(groceryList);

    setState(() {
      if (query.isEmpty) {
        // Reset filteredGroceryData to the original full list when the query is empty
        filteredGroceryData = List.from(dupedFilteredGroceryData);
      } else {
        // Apply the filtering based on the search query
        filteredGroceryData = dupedFilteredGroceryData
            .where(
                (meal) => meal.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    getSearchBarUI(),
                                    getTimeDateUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                  searchUI: getFilterBarUI(),
                                  itemCount: filteredGroceryData.length),
                            ),
                          ];
                        },
                        body: Container(
                          color: AppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            itemCount: filteredGroceryData.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count = filteredGroceryData.length > 10
                                  ? 10
                                  : filteredGroceryData.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController?.forward();
                              return GroceryListView(
                                callback: () {},
                                groceryData: filteredGroceryData[index],
                                animation: animation,
                                animationController: animationController!,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: filteredGroceryData.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = filteredGroceryData.length > 10
                          ? 10
                          : filteredGroceryData.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return GroceryListView(
                        callback: () {},
                        groceryData: filteredGroceryData[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    final List<Widget> GroceryListViews = <Widget>[];
    for (int i = 0; i < filteredGroceryData.length; i++) {
      final int count = filteredGroceryData.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      GroceryListViews.add(
        GroceryListView(
          callback: () {},
          groceryData: filteredGroceryData[i],
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: GroceryListViews,
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        bottom: 16,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      // showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Items in List',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '17',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          // Expanded(
          //   child: Row(
          //     children: <Widget>[
          //       Material(
          //         color: Colors.transparent,
          //         child: InkWell(
          //           focusColor: Colors.transparent,
          //           highlightColor: Colors.transparent,
          //           hoverColor: Colors.transparent,
          //           splashColor: Colors.grey.withOpacity(0.2),
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(4.0),
          //           ),
          //           onTap: () {
          //             FocusScope.of(context).requestFocus(FocusNode());
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.only(
          //                 left: 8, right: 8, top: 4, bottom: 4),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Text(
          //                   'Number of Rooms',
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.w100,
          //                       fontSize: 16,
          //                       color: Colors.grey.withOpacity(0.8)),
          //                 ),
          //                 const SizedBox(
          //                   height: 8,
          //                 ),
          //                 Text(
          //                   '1 Room - 2 Adults',
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w100,
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(14.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 12,
                    top: 4,
                    bottom: 4,
                  ),
                  child: TextField(
                    onChanged: onSearchChanged,
                    style: TextStyle(
                      fontSize: 16 * Scaler.textScaleFactor(context),
                    ),
                    cursorColor: AppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search for an item',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: AppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${filteredGroceryData.length} items found',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => FiltersScreen(
                            updateFilteredDataCallback: updateFilteredData,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: AppTheme.buildLightTheme().primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
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
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Grocery List',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22 + 6 - 6,
                    letterSpacing: 1.2,
                    color: AppTheme.darkerText,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.bagShopping,
                          size: 26,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  final Widget searchUI;
  final int itemCount;

  ContestTabHeader({required this.searchUI, required this.itemCount});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(ContestTabHeader oldDelegate) {
    // Rebuild if the item count changes
    return itemCount != oldDelegate.itemCount;
  }
}
