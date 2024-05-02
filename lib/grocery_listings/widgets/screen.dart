import 'package:flutter/material.dart';
import 'package:smart_fridge/grocery_listings/controllers/screen_controller.dart';
import 'package:smart_fridge/grocery_listings/models/grocery_listing_model.dart';

class GroceryScreen extends StatefulWidget {
  @override
  _GroceryScreenState createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  late GroceryScreenController _controller;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controller =
        GroceryScreenController(updateProductsList: updateProductsList);
    _controller.fetchProductsFromFirebase();
  }

  void updateProductsList(List<GroceryListingModel> products) {
    setState(() {
      // This will rebuild the widget with the new list of products
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery Listings"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: ProductSearchDelegate(_controller),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _controller.filteredProducts.length,
        itemBuilder: (context, index) {
          GroceryListingModel product = _controller.filteredProducts[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text("£${product.price.toStringAsFixed(2)}"),
            trailing: Image.network(product.image, width: 50, height: 50),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ProductSearchDelegate extends SearchDelegate<GroceryListingModel> {
  final GroceryScreenController controller;

  ProductSearchDelegate(this.controller);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.filterProducts(query);
    return ListView.builder(
      itemCount: controller.filteredProducts.length,
      itemBuilder: (context, index) {
        GroceryListingModel product = controller.filteredProducts[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text("£${product.price.toStringAsFixed(2)}"),
          trailing: Image.network(product.image, width: 50, height: 50),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.filterProducts(query);
    return ListView.builder(
      itemCount: controller.filteredProducts.length,
      itemBuilder: (context, index) {
        GroceryListingModel product = controller.filteredProducts[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text("£${product.price.toStringAsFixed(2)}"),
          trailing: Image.network(product.image, width: 50, height: 50),
        );
      },
    );
  }
}
