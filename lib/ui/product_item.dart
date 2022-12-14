import 'package:flutter/material.dart';
import 'package:ginger_shop/screens/product_page.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:ginger_shop/models/product_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ginger_shop/models/product.dart';
import 'package:ginger_shop/models/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/screens/edit_product.dart';
import 'package:ginger_shop/models/user_dao.dart';
import 'package:ginger_shop/ui/product_image.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final cart = context.watch<CartModel>();
    final userDao = context.watch<UserDao>();

    final bool isAdmin = userDao.isLoggedIn();

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: 108,
          child: GestureDetector(
            onTap: () {
              isAdmin
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditProduct(product: product),
                      ))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductPage(product: product),
                      ));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  child: ProductImage(
                    imageURL: product.imageUrl,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${product.brand} ${product.productName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 2.0)),
                            Expanded(
                              child: Text(
                                product.shortDescription,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Price: ${product.productPrice} USD',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 44,
                  child: (isAdmin)
                      ? IconButton(
                          iconSize: 18,
                          onPressed: () => showDialog<String>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: const Text(
                                      'Are you sure to delete this product?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                        deleteProduct(product.documentSnapshot);
                                      },
                                      child: const Text('OK'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                ),
                              ),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black54,
                          ))
                      : Column(
                          children: [
                            IconButton(
                              iconSize: 18,
                              onPressed: () {
                                cart.add(product: product);
                              },
                              //icon: const Icon(Icons.shopping_cart_outlined),
                              icon: kShoppingCartIcon,
                            ),
                            IconButton(
                                iconSize: 18,
                                onPressed: () {
                                  editProductFavourite(
                                      product.isFavourite, product.id);
                                },
                                icon: (product.isFavourite)
                                    ? const Icon(Icons.favorite)
                                    : const Icon(
                                        Icons.favorite_outline_outlined)),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
