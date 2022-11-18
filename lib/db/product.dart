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
  final String
      productPrice; //TODO: change to double in database and everywhere in code
  final String imageUrl;
  final String shortDescription;
  final bool isFavourite;
  final String id;
  final DocumentSnapshot documentSnapshot;
  int numberOfProducts;
}
