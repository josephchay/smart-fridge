import 'package:cloud_firestore/cloud_firestore.dart';

class GroceryListingModel {
  int id;
  String name;
  String category;
  String brand;
  double price;
  String image; // Assuming image is stored as a URL or a base64 string

  GroceryListingModel({
    this.id = 0,
    this.name = "",
    this.category = "",
    this.brand = "",
    this.price = 0.0,
    this.image = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'brand': brand,
      'price': price,
      'image': image,
    };
  }

  factory GroceryListingModel.fromJson(Map<String, dynamic> json) {
    return GroceryListingModel(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
    );
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<GroceryListingModel>> loadTescoProductsFromFirebase() async {
  QuerySnapshot snapshot =
      await _firestore.collection('api_tesco_backup').get();

  return snapshot.docs.map((doc) {
    return GroceryListingModel.fromJson(doc.data() as Map<String, dynamic>);
  }).toList();
}
