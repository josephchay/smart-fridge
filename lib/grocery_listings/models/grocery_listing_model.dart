class GroceryListingModel {
  int id;
  String name;
  String category;
  String brand;
  double price;
  String image;

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
