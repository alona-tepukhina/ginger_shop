import 'package:flutter/material.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:ginger_shop/models/user_dao.dart';
import 'package:ginger_shop/utilities/validators.dart';
import 'package:ginger_shop/models/product_dao.dart';
import 'package:ginger_shop/models/product.dart';
import 'package:ginger_shop/ui/product_image.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  late String id;
  String? brand;
  String? productName;
  num price = 0;
  String? shortDescription;
  String? imageURL;
  bool isFavourite = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _shortDescriptionController =
      TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();

  @override
  void initState() {
    _brandController.text = widget.product.brand;
    _productNameController.text = widget.product.productName;
    _priceController.text = widget.product.productPrice.toString();
    _shortDescriptionController.text = widget.product.shortDescription;
    _imageURLController.text = widget.product.imageUrl;
    imageURL = _imageURLController.text;
    super.initState();
  }

  @override
  void dispose() {
    _brandController.dispose();
    _productNameController.dispose();
    _priceController.dispose();
    _shortDescriptionController.dispose();
    _imageURLController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit product'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  kSizedBoxHalfHeight,
                  SizedBox(
                    width: 296,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _brandController,
                      decoration: const InputDecoration(
                        label: Text('Brand'),
                        border: UnderlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  kSizedBoxHalfHeight,
                  SizedBox(
                    width: 296,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _productNameController,
                      decoration: const InputDecoration(
                        label: Text('Product name'),
                        border: UnderlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  kSizedBoxHalfHeight,
                  SizedBox(
                    width: 296,
                    child: TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _priceController,
                      decoration: const InputDecoration(
                        label: Text('Product price'),
                        border: UnderlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  kSizedBoxHalfHeight,
                  SizedBox(
                    width: 296,
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _imageURLController,
                      decoration: const InputDecoration(
                        label: Text('Product image URL'),
                        border: UnderlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value != null && value != '') {
                          if (!value.isValidURL()) {
                            return 'Invalid URL';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  kSizedBoxHalfHeight,
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: const Text('Preview image'),
                        onPressed: () {
                          setState(() {
                            imageURL = _imageURLController.text;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      SizedBox(
                        height: kPreviewImageHeight,
                        width: 200,
                        child: ProductImage(
                          imageURL: imageURL,
                        ),
                      ),
                    ],
                  ),
                  kSizedBoxHalfHeight,
                  SizedBox(
                    width: 296,
                    child: TextFormField(
                      controller: _shortDescriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        label: Text('Short description'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  kSizedBoxHalfHeight,
                  ElevatedButton(
                    child: const Text('Save changes'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await editProduct(
                          id: widget.product.id,
                          brand: _brandController.text,
                          productName: _productNameController.text,
                          productPrice: double.parse(_priceController.text),
                          shortDescription: _shortDescriptionController.text,
                          imageUrl: _imageURLController.text,
                        );

                        await Future.delayed(const Duration(seconds: 1));
                        if (!context.mounted) return;
                        //Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Saved changed')));

                        //_formKey.currentState?.reset();
                      }
                    },
                  ),
                  OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
