import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ginger_shop/screens/add_product.dart';
import 'package:ginger_shop/ui/product_item.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/db/user_dao.dart';
import 'package:ginger_shop/ui/main_menu.dart';
import 'package:ginger_shop/db/product.dart';
import 'package:ginger_shop/screens/cart_screen.dart';
import 'package:ginger_shop/db/cart_model.dart';
import 'package:ginger_shop/ui/appbar_cart_iconbutton.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDao = Provider.of<UserDao>(context, listen: false);

    bool isAdmin = userDao.isLoggedIn();

    return Scaffold(
      drawer: const Drawer(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: MainMenu(),
        ),
      ),
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: const [
          AppbarCartIconButton(),
        ],
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
                    final product = Product(
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
