import 'package:flutter/material.dart';
import 'package:ginger_shop/ui/product_item.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:ginger_shop/db/product.dart';
import 'package:ginger_shop/db/product_dao.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/db/cart_model.dart';
import 'package:ginger_shop/ui/appbar_cart_iconbutton.dart';
import 'package:ginger_shop/ui/product_image.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    // Icon favouritesIcon = (product.isFavourite)
    //     ? const Icon(Icons.favorite)
    //     : const Icon(Icons.favorite_outline_outlined);

    final cart = context.watch<CartModel>();

    final selectedProduct = product;

    int tmpNumberOfProducts = cart.tmpNumberOfProducts;
    double tmpPrice = cart.getTmpPrice(selectedProduct);
    double totalPrice = product.productPrice;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            cart.setDefaultTmpNumberOfProducts();
            Navigator.pop(context);
          },
        ),
        actions: const [
          AppbarCartIconButton(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kSizedBoxHalfHeight,
                SizedBox(
                  height: 200,
                  width: 200,
                  // child: Stack(
                  //   children: [
                  //     ProductImage(
                  //       imageURL: product.imageUrl,
                  //     ),
                  //     Align(
                  //       alignment: Alignment.topRight,
                  //       child: IconButton(
                  //         iconSize: 18,
                  //         onPressed: () {
                  //           editProductFavourite(
                  //               product.isFavourite, product.id);
                  //         },
                  //         icon: favouritesIcon,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  child: ProductImage(
                    imageURL: product.imageUrl,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSizedBoxFullHeight,
                    Text(
                      product.productName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    kSizedBoxHalfHeight,
                    Row(
                      children: [
                        const Text(
                          'Brand: ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          product.brand,
                        ),
                      ],
                    ),
                    kSizedBoxHalfHeight,
                    const Divider(),
                    kSizedBoxHalfHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Price: $tmpPrice USD',
                          style: const TextStyle(
                              //fontSize: 12.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cart.decreaseTmpNumberOfProducts();
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                size: 20,
                                color: Colors.black38,
                              ),
                            ),
                            Text('$tmpNumberOfProducts'),
                            IconButton(
                              onPressed: () {
                                cart.increaseTmpNumberOfProducts();
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                                size: 20,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cart.add(
                                product: product,
                                numberOfProducts: tmpNumberOfProducts);
                            cart.setDefaultTmpNumberOfProducts();
                          },
                          child: const Text('Add to cart'),
                        ),
                      ],
                    ),
                    kSizedBoxHalfHeight,
                    const Divider(),
                    kSizedBoxHalfHeight,
                    const Text(
                      'Description: ',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    kSizedBoxHalfHeight,
                    Text(
                      product.shortDescription,
                      style: const TextStyle(
                        //fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
