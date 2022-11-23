import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ginger_shop/db/product.dart';

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

Future<void> editProduct({
  required String id,
  required String brand,
  required String productName,
  double productPrice = 0,
  String? shortDescription,
  String? imageUrl,
}) async {
  await FirebaseFirestore.instance.collection('products').doc(id).update({
    //await FirebaseFirestore.instance.collection('products').doc(id).set({
    'brand': brand,
    'productName': productName,
    'price': productPrice,
    'shortDescription': shortDescription ?? '',
    'imageURL': imageUrl,
  });
}

// Future<void> editProduct(Product product) async {
//   await FirebaseFirestore.instance
//       .collection('products')
//       .doc(product.id)
//       .update({
//     //await FirebaseFirestore.instance.collection('products').doc(id).set({
//     'brand': product.brand,
//     'productName': product.productName,
//     'price': product.productPrice,
//     'shortDescription': product.shortDescription ?? '',
//     'imageURL': product.imageUrl,
//   });
// }

// used on frontend by client
Future<void> editProductFavourite(bool isFavourite, String id) async {
  await FirebaseFirestore.instance.collection('products').doc(id).update({
    'isFavourite': !isFavourite,
  });
}

Future<void> deleteProduct(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance.collection('products').doc(doc.id).delete();
}
