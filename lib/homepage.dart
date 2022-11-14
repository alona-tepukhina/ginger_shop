import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ginger_shop/add_product.dart';
import 'package:ginger_shop/product_item.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/db_operations/user_dao.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: const Text('Home'),
                onTap: () => Navigator.of(context).pushNamed('/home'),
              ),
              const Divider(),
              ListTile(
                title: const Text('Add product'),
                onTap: () => Navigator.of(context).pushNamed('/addProduct'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Products list'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          return (!snapshot.hasData)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return ProductItem(
                        brand: data['brand'],
                        productName: data['productName'],
                        productPrice: data['price'],
                        imageUrl: data['imageURL'],
                        shortDescription: data['shortDescription'],
                        isFavourite: data['isFavourite'],
                        id: data.id,
                        documentSnapshot: data);
                  });
        },
      ),
    );
  }
}
