import 'package:flutter/cupertino.dart';
import 'package:ginger_shop/models/product.dart';

class ProductTmpCartModel extends ChangeNotifier {
  double tmpPrice = 0;
  int tmpNumberOfProducts = 1;

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
}
