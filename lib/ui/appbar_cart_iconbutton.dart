import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/models/cart_model.dart';
import 'package:ginger_shop/utilities/constants.dart';

class AppbarCartIconButton extends StatefulWidget {
  const AppbarCartIconButton({
    super.key,
  });

  @override
  State<AppbarCartIconButton> createState() => _AppbarCartIconButtonState();
}

class _AppbarCartIconButtonState extends State<AppbarCartIconButton> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          icon: kShoppingCartIcon,
        ),
        Visibility(
          visible: cart.cartIsNotEmpty,
          child: const Positioned(
            top: 8,
            right: 4,
            child: Icon(
              Icons.circle,
              size: 10,
              color: Colors.greenAccent,
            ),
          ),
        ),
      ],
    );

    // return IconButton(
    //   onPressed: () {
    //     Navigator.pushNamed(context, '/cart');
    //   },
    //   icon: kShoppingCartIcon,
    // );
  }
}
