import 'package:flutter/cupertino.dart';
import 'dart:collection';
import 'package:ginger_shop/db/product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  bool get cartIsEmpty => _products.isEmpty;

  bool get cartIsNotEmpty => _products.isNotEmpty;

  //int get totalPrice => products.price.reduce((value, element) => value + element)
  //TODO: implement total price
  //int get totalPrice => _products.length;

  double getTotalPrice() {
    if (cartIsEmpty) {
      return 0;
    } else {
      double totalPrice = 0;
      for (var product in _products) {
        totalPrice +=
            product.numberOfProducts * double.parse(product.productPrice);
      }
      return totalPrice;
    }
  }

  // not sure if it works
  void add(Product product) {
    if (!_products.contains(product)) {
      product.numberOfProducts = 1;
      _products.add(product);
      notifyListeners();
    } else {
      _products[_products.indexOf(product)].numberOfProducts++;
      notifyListeners();
    }
  }

  void remove(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void removeAll() {
    _products.clear();
    notifyListeners();
  }
}
