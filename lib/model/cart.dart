import 'package:f08_eshop_app/model/cart_item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  void add(CartItem item) {
    _items.add(item);

    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);

    notifyListeners();
  }

  void increment(int index) {
    _items[index].quantity += 1;

    notifyListeners();
  }

  void decrement(int index) {
    _items[index].quantity -= 1;

    if (_items[index].quantity <= 0) {
      remove(index);
    } else {
      notifyListeners();
    }
  }

  void clear() {
    _items = [];
  }
}
