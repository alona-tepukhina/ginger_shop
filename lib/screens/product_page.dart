import 'package:flutter/material.dart';
import 'package:ginger_shop/ui/product_item.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:ginger_shop/db/product.dart';
import 'package:ginger_shop/db/product_dao.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/db/cart_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ginger_shop/ui/appbar_cart_iconbutton.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    // Icon favouritesIcon = (widget.product.isFavourite)
    //     ? const Icon(Icons.favorite)
    //     : const Icon(Icons.favorite_outline_outlined);

    final cart = context.watch<CartModel>();

    final selectedProduct = widget.product;

    int tmpNumberOfProducts = cart.tmpNumberOfProducts;
    double tmpPrice = cart.getTmpPrice(selectedProduct);
    double totalPrice = widget.product.productPrice;

    bool isFavouriteProduct = widget.product.isFavourite;

    Icon favouritesIcon = (isFavouriteProduct)
        ? Icon(
            Icons.favorite,
            key: UniqueKey(),
          )
        : Icon(
            Icons.favorite_outline_outlined,
            key: UniqueKey(),
          );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productName),
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
                  child: Stack(
                    children: [
                      (widget.product.imageUrl != '')
                          ? Image.network(
                              widget.product.imageUrl,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return kDefaultListImagePlaceholder;
                              },
                            )
                          : kDefaultListImagePlaceholder,
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          iconSize: 18,
                          onPressed: () {
                            setState(() {
                              editProduct(widget.product.isFavourite,
                                  widget.product.id);
                            });
                          },
                          icon: favouritesIcon,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSizedBoxFullHeight,
                    Text(
                      widget.product.productName,
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
                          widget.product.brand,
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
                                product: widget.product,
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
                      widget.product.shortDescription,
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
