import 'package:flutter/material.dart';
import 'package:ginger_shop/screens/product_page.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:ginger_shop/db/product_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ginger_shop/db/product.dart';
import 'package:ginger_shop/db/cart_model.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key, required this.product, this.isAdmin = false})
      : super(key: key);

  final Product product;
  final bool isAdmin;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    // Not sure
    final cart = context.watch<CartModel>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: 108,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
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
                AspectRatio(
                  aspectRatio: 1.0,
                  //child: Image.network(widget.imageUrl),
                  child: (product.imageUrl != '')
                      ? Image.network(
                          product.imageUrl,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return kDefaultListImagePlaceholder;
                          },
                        )
                      : kDefaultListImagePlaceholder,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              product.shortDescription,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
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

                      // Align(
                      //   alignment: Alignment.bottomLeft,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: <Widget>[
                      //       Text(
                      //         'Price: ${widget.productPrice} USD',
                      //         style: const TextStyle(
                      //           fontSize: 12.0,
                      //           color: Colors.black87,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 44,
                  child: (widget.isAdmin)
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
                                  editProduct(product.isFavourite, product.id);
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
