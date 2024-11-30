import 'package:f08_eshop_app/model/order.dart';
import 'package:f08_eshop_app/model/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderUtils {
  static double getTotalPrice(BuildContext context, Order order,
      {bool listen = true}) {
    final products = Provider.of<ProductList>(context, listen: listen).items;

    return order.items.fold(0.0, (value, item) {
      final product =
          products.firstWhere((product) => product.id == item.productId);

      return value + item.quantity * product.price;
    });
  }
}
