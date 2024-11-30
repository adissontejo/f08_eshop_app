import 'package:f08_eshop_app/model/cart_item.dart';

class Order {
  final String id;
  final String creatorUserId;
  final List<CartItem> items;

  const Order(
      {required this.id, required this.creatorUserId, required this.items});

  factory Order.fromJson(String id, Map<String, dynamic> json) {
    return Order(
      id: id,
      creatorUserId: json['creatorUserId'],
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creatorUserId': creatorUserId,
      'items': items.map((e) => e.toJson()).toList()
    };
  }
}
