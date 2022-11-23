import 'package:flutter/cupertino.dart';
import 'dart:collection';
import 'package:ginger_shop/db/product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];

  double tmpPrice = 0;
  int tmpNumberOfProducts = 1;

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  bool get cartIsEmpty => _products.isEmpty;

  bool get cartIsNotEmpty => _products.isNotEmpty;

  double getTotalPrice() {
    if (cartIsEmpty) {
      return 0;
    } else {
      double totalPrice = 0;
      for (var product in _products) {
        totalPrice += product.numberOfProducts * product.productPrice;
      }
      return totalPrice;
    }
  }

  void setDefaultTmpNumberOfProducts() {
    tmpNumberOfProducts = 1;
    notifyListeners();
  }

  void increaseTmpNumberOfProducts() {
    tmpNumberOfProducts++;
    notifyListeners();
  }

  void decreaseTmpNumberOfProducts() {
    if (tmpNumberOfProducts > 1) {
      tmpNumberOfProducts--;
      notifyListeners();
    }
  }

  double getTmpPrice(Product product) {
    return tmpPrice = tmpNumberOfProducts * product.productPrice;
    notifyListeners();
  }

  void add({required Product product, int numberOfProducts = 1}) {
    if (!_products.contains(product)) {
      product.numberOfProducts = numberOfProducts;
      _products.add(product);
      notifyListeners();
    } else {
      _products[_products.indexOf(product)].numberOfProducts +=
          numberOfProducts;
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
