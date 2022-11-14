import 'package:flutter/material.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:ginger_shop/db_operations/user_dao.dart';
import 'package:ginger_shop/utilities/validators.dart';

import 'db_operations/db_product_operations.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late String id;
  String? brand;
  String? productName;
  double price = 0;
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
        title: const Text('Add products'),
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
                        if (value != null) {
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
                        //width: 200,
                        child: ((imageURL != null) && (imageURL != ''))
                            ? Image.network(
                                imageURL!,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return kDefaultListImagePlaceholder;
                                },
                              )
                            : kDefaultListImagePlaceholder,
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
                    child: const Text('Add product'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await addProduct(
                            brand: _brandController.text,
                            productName: _productNameController.text,
                            price: _priceController.text,
                            shortDescription: _shortDescriptionController.text,
                            imageURL: _imageURLController.text,
                            isFavourite: isFavourite);

                        await Future.delayed(const Duration(seconds: 1));
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Product added successfully')));

                        _formKey.currentState?.reset();
                      }
                    },
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
