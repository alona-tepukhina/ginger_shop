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
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/cart');
        //     },
        //     icon: kShoppingCartIcon,
        //   ),
        // ],
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
                          icon: const Icon(Icons.remove_shopping_cart),
                          onPressed: () {
                            cart.remove(cart.products[index]);
                          },
                        ),
                        title: Text(
                          '${cart.products[index].productName}:  ${cart.products[index].numberOfProducts}',
                        ),
                      ),
                    ),
                  ),
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
