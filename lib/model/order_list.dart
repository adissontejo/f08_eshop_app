import 'dart:convert';

import 'package:f08_eshop_app/model/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  final _baseUrl = 'https://ddm20242-94e9c-default-rtdb.firebaseio.com/';

  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<List<Order>> fetchOrders() async {
    List<Order> orders = [];

    try {
      final response = await http.get(Uri.parse('$_baseUrl/orders.json'));

      if (response.statusCode == 200) {
        Map<String, dynamic> _ordersJson =
            jsonDecode(response.body == "null" ? "{}" : response.body);

        _ordersJson.forEach((id, order) {
          orders.add(Order.fromJson(id, order));
        });
        _orders = orders;

        return orders;
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOrder(Order order) async {
    try {
      var response = await http.post(Uri.parse('$_baseUrl/orders.json'),
          body: jsonEncode(order.toJson()));

      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['name'];
        _orders.add(Order(
          id: id,
          creatorUserId: order.creatorUserId,
          items: order.items,
        ));
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }
}
