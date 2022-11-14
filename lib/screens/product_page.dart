import 'package:flutter/material.dart';
import 'package:ginger_shop/ui/product_item.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:ginger_shop/db/db_product.dart';
import 'package:ginger_shop/db/product_dao.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.product}) : super(key: key);

  final DBProduct product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    Icon favouritesIcon = (widget.product.isFavourite)
        ? const Icon(Icons.favorite)
        : const Icon(Icons.favorite_outline_outlined);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productName),
        centerTitle: true,
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
                            editProduct(
                                widget.product.isFavourite, widget.product.id);
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
                    kSizedBoxHalfHeight,
                    Text(
                      'Price: ${widget.product.productPrice} USD',
                      style: const TextStyle(
                          //fontSize: 12.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    // kSizedBoxHalfHeight,
                    // const Divider(),
                    // kSizedBoxHalfHeight,
                    // OutlinedButton(
                    //     onPressed: () {}, child: Text('Add to favourites')),
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
