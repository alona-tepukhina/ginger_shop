import 'package:flutter/material.dart';
import 'package:ginger_shop/utilities/constants.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key, this.imageURL}) : super(key: key);

  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return ((imageURL != null) && (imageURL != ''))
        ? Image.network(
            imageURL!,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return kDefaultListImagePlaceholder;
            },
          )
        : kDefaultListImagePlaceholder;
  }
}
