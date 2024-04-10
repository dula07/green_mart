import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String description;
  final String id;
  final String imgUrl;
  final String name;
  final double price;
  final String productCategory;

  Product({
    required this.description,
    required this.id,
    required this.imgUrl,
    required this.name,
    required this.price,
    required this.productCategory,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Product(
      description: data['description'] ?? '',
      id: doc.id,
      imgUrl: data['img_url'] ?? '',
      name: data['name'] ?? '',
      price: data['price'] is double ? data['price'] : double.tryParse(data['price'].toString()) ?? 0.0,
      productCategory: data['product_category'] ?? '',
    );
  }
}
