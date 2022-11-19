import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addProduct({
  required String brand,
  required String productName,
  double? price,
  String? shortDescription,
  String? imageURL,
  bool isFavourite = false,
}) async {
  await FirebaseFirestore.instance.collection("products").add({
    'brand': brand,
    'productName': productName,
    'price': price,
    'shortDescription': shortDescription ?? '',
    'imageURL': imageURL,
    'isFavourite': isFavourite,
  });
}

Future<void> editProduct(bool isFavourite, String id) async {
  await FirebaseFirestore.instance.collection('products').doc(id).update({
    //await FirebaseFirestore.instance.collection('products').doc(id).set({
    'isFavourite': !isFavourite,
  });
}

Future<void> deleteProduct(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance.collection('products').doc(doc.id).delete();
}
