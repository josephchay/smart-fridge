import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_fridge/grocery_listings/models/grocery_listing_model.dart';
import 'package:smart_fridge/grocery_listings/widgets/grocery_cart_view.dart';
import 'package:smart_fridge/config/math/scaler.dart';
import 'package:smart_fridge/config/themes/app_theme.dart';
import 'package:get_storage/get_storage.dart';

class GroceryCartScreen extends StatefulWidget {
  List<GroceryListingModel> storageGroceryData = [];

  GroceryCartScreen({Key? key, required this.storageGroceryData})
      : super(key: key);

  @override
  _GroceryCartScreenState createState() => _GroceryCartScreenState();
}

class _GroceryCartScreenState extends State<GroceryCartScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  void removeItemFromCart(GroceryListingModel item) {
    setState(() {
      int index = widget.storageGroceryData
          .indexWhere((element) => element.name == item.name);
      if (index != -1) {
        widget.storageGroceryData
            .removeAt(index); // Removes the first instance found
      }
    });
    updateStorage(); // Update the local storage with the new state of the list
  }

  void updateStorage() {
    final storage = GetStorage();
    // Convert your list of grocery items to a JSON string
    List<Map<String, dynamic>> jsonData =
        widget.storageGroceryData.map((item) => item.toJson()).toList();
    // Write this JSON string to the local storage
    storage.write('groceryListings', jsonEncode(jsonData));
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
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
                                    getTimeDateUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                          ];
                        },
                        body: Container(
                          color: AppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            itemCount: widget.storageGroceryData.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count =
                                  widget.storageGroceryData.length > 10
                                      ? 10
                                      : widget.storageGroceryData.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController?.forward();

                              return GroceryCartView(
                                callback: () => removeItemFromCart(
                                    widget.storageGroceryData[index]),
                                groceryData: widget.storageGroceryData[index],
                                animation: animation,
                                animationController: animationController!,
                                storageGroceryData: widget.storageGroceryData,
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
                    itemCount: widget.storageGroceryData.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = widget.storageGroceryData.length > 10
                          ? 10
                          : widget.storageGroceryData.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return GroceryCartView(
                        callback: () => removeItemFromCart(
                            widget.storageGroceryData[index]),
                        groceryData: widget.storageGroceryData[index],
                        animation: animation,
                        animationController: animationController!,
                        storageGroceryData: widget.storageGroceryData,
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
    for (int i = 0; i < widget.storageGroceryData.length; i++) {
      final int count = widget.storageGroceryData.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      GroceryListViews.add(
        GroceryCartView(
          callback: () => removeItemFromCart(widget.storageGroceryData[i]),
          groceryData: widget.storageGroceryData[i],
          animation: animation,
          animationController: animationController!,
          storageGroceryData: widget.storageGroceryData,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: GroceryListViews,
    );
  }

  Widget getTimeDateUI() {
    // Calculate total cost dynamically
    double totalCost = widget.storageGroceryData
        .fold(0, (double sum, item) => sum + double.parse(item.price));

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // This will justify the space between elements
        children: <Widget>[
          // First Column for Items Count
          Expanded(
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
                const SizedBox(height: 8),
                Text(
                  widget.storageGroceryData.length.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Second Column for Total Cost
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Total Cost',
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 16,
                      color: Colors.grey.withOpacity(0.8)),
                ),
                const SizedBox(height: 8),
                Text(
                  'RM${totalCost.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                  'Grocery Cart Items',
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
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // create a close button
                          child: Icon(
                            Icons.close,
                            color: AppTheme.grey,
                          )),
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
