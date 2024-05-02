import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_fridge/grocery_listings/models/grocery_listing_model.dart';

class GroceryScreenController {
  final Function(List<GroceryListingModel>) updateProductsList;
  List<GroceryListingModel> allProducts = [];
  List<GroceryListingModel> filteredProducts = [];

  GroceryScreenController({required this.updateProductsList});

  Future<void> fetchProductsFromFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firestore.collection('api_tesco_backup').get();
    allProducts = snapshot.docs
        .map((doc) =>
            GroceryListingModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    filteredProducts = List.from(allProducts);
    updateProductsList(filteredProducts);
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = List.from(allProducts);
    } else {
      filteredProducts = allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    updateProductsList(filteredProducts);
  }
}
