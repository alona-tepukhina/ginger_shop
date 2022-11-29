import 'package:flutter/material.dart';
import 'package:ginger_shop/ui/main_menu.dart';
import 'package:ginger_shop/db/cart_model.dart';
import 'package:ginger_shop/ui/cart_is_empty.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/ui/product_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    var totalPrice = cart.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: cart.cartIsEmpty
            ? const CartIsEmptyWidget()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.products.length,
                      itemBuilder: (context, index) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                                child: ProductImage(
                                  imageURL: cart.products[index].imageUrl,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cart.products[index].brand,
                                              ),
                                              Text(cart
                                                  .products[index].productName),
                                              kSizedBoxHalfHeight,
                                              Text(
                                                '${cart.products[index].productPrice * cart.products[index].numberOfProducts} USD',
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cart.decreaseCartNumberOfProducts(
                                                cart.products[index]);
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                            size: 20,
                                            color: Colors.black38,
                                          ),
                                        ),
                                        Text(
                                            '${cart.products[index].numberOfProducts}'),
                                        IconButton(
                                          onPressed: () {
                                            cart.increaseCartNumberOfProducts(
                                                cart.products[index]);
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                            size: 20,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    cart.remove(cart.products[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: cart.products.length,
                  //     itemBuilder: (context, index) => ListTile(
                  //       trailing: IconButton(
                  //         icon: const Icon(Icons.delete),
                  //         onPressed: () {
                  //           cart.remove(cart.products[index]);
                  //         },
                  //       ),
                  //       title: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Expanded(
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   cart.products[index].brand,
                  //                 ),
                  //                 Text(cart.products[index].productName),
                  //               ],
                  //             ),
                  //           ),
                  //           Text('${cart.products[index].numberOfProducts}'),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  kSizedBoxFullHeight,
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Total price: '),
                        Text(
                          '$totalPrice USD',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
