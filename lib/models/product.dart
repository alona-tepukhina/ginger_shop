import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product({
    required this.brand,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.shortDescription,
    required this.isFavourite,
    required this.id,
    required this.documentSnapshot,
    this.numberOfProducts = 0,
  });

  final String brand;
  final String productName;
  final double productPrice; // num in database
  final String imageUrl;
  final String shortDescription;
  final bool isFavourite;
  final String id;
  final DocumentSnapshot documentSnapshot;
  int numberOfProducts;
}
