// Product taken from Database

import 'package:cloud_firestore/cloud_firestore.dart';

class DBProduct {
  DBProduct({
    required this.brand,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.shortDescription,
    required this.isFavourite,
    required this.id,
    required this.documentSnapshot,
  });

  final String brand;
  final String productName;
  final String productPrice;
  final String imageUrl;
  final String shortDescription;
  final bool isFavourite;
  final String id;
  final DocumentSnapshot documentSnapshot;
}
