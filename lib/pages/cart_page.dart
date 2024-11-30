import 'package:f08_eshop_app/components/app_drawer.dart';
import 'package:f08_eshop_app/model/cart.dart';
import 'package:f08_eshop_app/model/order.dart';
import 'package:f08_eshop_app/model/order_list.dart';
import 'package:f08_eshop_app/model/product_list.dart';
import 'package:f08_eshop_app/model/user_list.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.items;
    final products = Provider.of<ProductList>(context).items;
    final itemsProducts = items
        .map((item) =>
            products.firstWhere((product) => item.productId == product.id))
        .toList();

    double totalPrice = 0;

    for (int i = 0; i < items.length; i++) {
      totalPrice += items[i].quantity * itemsProducts[i].price;
    }

    void submitOrder() async {
      await Provider.of<OrderList>(context, listen: false).addOrder(
        Order(
          id: "",
          creatorUserId:
              Provider.of<UserList>(context, listen: false).loggedUser!.id,
          items: items,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compra realizada com sucesso!')),
      );
      cart.clear();
      Navigator.pushReplacementNamed(context, AppRoutes.ORDERS);
    }

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Meu Carrinho'),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text('Seu carrinho está vazio!'),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                final item = items[index];
                final product = itemsProducts[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Text('${item.quantity}x'),
                    ),
                    title: Text(product.title),
                    subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => cart.decrement(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => cart.increment(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => cart.remove(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: R\$ ${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: items.isEmpty ? null : submitOrder,
              child: const Text('Finalizar Compra'),
            ),
          ],
        ),
      ),
    );
  }
}
