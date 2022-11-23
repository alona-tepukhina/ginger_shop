import 'package:flutter/material.dart';
import 'package:ginger_shop/ui/main_menu.dart';
import 'package:ginger_shop/db/cart_model.dart';
import 'package:ginger_shop/ui/cart_is_empty.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    var totalPrice = cart.getTotalPrice();

    // final selectedProduct = widget.product;
    // int tmpNumberOfProducts = cart.tmpNumberOfProducts;
    // double tmpPrice = cart.getTmpPrice(selectedProduct);
    // double totalPrice = widget.product.productPrice;

    return Scaffold(
      // drawer: const Drawer(
      //   child: Padding(
      //     padding: EdgeInsets.all(8.0),
      //     child: MainMenu(),
      //   ),
      // ),
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
                      itemBuilder: (context, index) => ListTile(
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cart.remove(cart.products[index]);
                          },
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart.products[index].brand,
                                  ),
                                  Text(cart.products[index].productName),
                                ],
                              ),
                            ),
                            Text('${cart.products[index].numberOfProducts}'),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Expanded(
                  //   child: ListView.builder(
                  //       itemCount: cart.products.length,
                  //       itemBuilder: (context, index) => Card(
                  //             child: Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(vertical: 8.0),
                  //               child: SizedBox(
                  //                 height: 72,
                  //                 child: Column(
                  //                   children: [
                  //                     Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.start,
                  //                       children: <Widget>[
                  //                         AspectRatio(
                  //                           aspectRatio: 1.0,
                  //                           child: (cart.products[index]
                  //                                       .imageUrl !=
                  //                                   '')
                  //                               ? Image.network(
                  //                                   cart.products[index]
                  //                                       .imageUrl,
                  //                                   errorBuilder:
                  //                                       (BuildContext context,
                  //                                           Object exception,
                  //                                           StackTrace?
                  //                                               stackTrace) {
                  //                                     return kDefaultListImagePlaceholder;
                  //                                   },
                  //                                 )
                  //                               : kDefaultListImagePlaceholder,
                  //                         ),
                  //                         Expanded(
                  //                           child: Text(
                  //                             '${cart.products[index].brand} ${cart.products[index].productName}',
                  //                           ),
                  //                         ),
                  //                         IconButton(
                  //                           icon: const Icon(Icons.delete),
                  //                           onPressed: () {
                  //                             cart.remove(cart.products[index]);
                  //                           },
                  //                         ),
                  //                         Row(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           children: [
                  //                             IconButton(
                  //                               onPressed: () {
                  //                                 cart.decreaseTmpNumberOfProducts();
                  //                               },
                  //                               icon: const Icon(
                  //                                 Icons.remove_circle_outline,
                  //                                 size: 20,
                  //                                 color: Colors.black38,
                  //                               ),
                  //                             ),
                  //                             Text(
                  //                               '${cart.products[index].numberOfProducts}',
                  //                             ),
                  //                             IconButton(
                  //                               onPressed: () {
                  //                                 cart.increaseTmpNumberOfProducts();
                  //                               },
                  //                               icon: const Icon(
                  //                                 Icons.add_circle_outline,
                  //                                 size: 20,
                  //                                 color: Colors.black38,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           )),
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
