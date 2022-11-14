import 'package:flutter/material.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:ginger_shop/db_operations/product_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductItem extends StatefulWidget {
  const ProductItem(
      {Key? key,
      required this.brand,
      required this.productName,
      required this.productPrice,
      required this.imageUrl,
      required this.shortDescription,
      required this.isFavourite,
      required this.id,
      required this.documentSnapshot,
      this.isAdmin = false})
      : super(key: key);

  final String brand;
  final String productName;
  final String productPrice;
  final String imageUrl;
  final String shortDescription;
  final bool isFavourite;
  final String id;
  final DocumentSnapshot documentSnapshot;
  final bool isAdmin;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: 108,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                //child: Image.network(widget.imageUrl),
                child: (widget.imageUrl != '')
                    ? Image.network(
                        widget.imageUrl,
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
                            '${widget.brand} ${widget.productName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                          Text(
                            widget.shortDescription,
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
                      'Price: ${widget.productPrice} USD',
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
                                      deleteProduct(widget.documentSnapshot);
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
                    : IconButton(
                        iconSize: 18,
                        onPressed: () {
                          editProduct(widget.isFavourite, widget.id);
                        },
                        icon: (widget.isFavourite)
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_outline_outlined)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
