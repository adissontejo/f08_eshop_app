import 'package:f08_eshop_app/model/product.dart';

class CartItem {
  String productId;
  int quantity;

  CartItem({required this.productId, this.quantity = 1});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    print(json);

    return CartItem(productId: json['productId'], quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
