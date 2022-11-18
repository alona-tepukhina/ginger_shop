import 'package:flutter/material.dart';

class CartIsEmptyWidget extends StatelessWidget {
  const CartIsEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 20, color: Colors.black87),
          ),
          const SizedBox(
            height: 24,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('Continue shopping'),
          ),
        ],
      ),
    );
  }
}
