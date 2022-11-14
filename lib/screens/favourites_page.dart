import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ginger_shop/screens/add_product.dart';
import 'package:ginger_shop/ui/product_item.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/db/user_dao.dart';
import 'package:ginger_shop/ui/main_menu.dart';
import 'package:ginger_shop/db/db_product.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsRef = FirebaseFirestore.instance.collection('products');
    final query = productsRef.where("isFavourite", isEqualTo: true);

    return Scaffold(
      drawer: const Drawer(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: MainMenu(),
        ),
      ),
      appBar: AppBar(
        title: const Text('Favourite products'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        //stream: FirebaseFirestore.instance.collection('products').snapshots(),
        stream: query.snapshots(),
        builder: (context, snapshot) {
          return (!snapshot.hasData)
              //? const Center(child: CircularProgressIndicator())
              ? const Text('List of favourite products is empty')
              : ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    final product = DBProduct(
                        brand: data['brand'],
                        productName: data['productName'],
                        productPrice: data['price'],
                        imageUrl: data['imageURL'],
                        shortDescription: data['shortDescription'],
                        isFavourite: data['isFavourite'],
                        id: data.id,
                        documentSnapshot: data);
                    return ProductItem(product: product);
                  });
        },
      ),
    );
  }
}
