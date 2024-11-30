import 'package:f08_eshop_app/model/product_list.dart';
import 'package:f08_eshop_app/utils/order_utils.dart';
import 'package:flutter/material.dart';
import 'package:f08_eshop_app/model/order.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Order order = ModalRoute.of(context)!.settings.arguments as Order;

    final productProvider = Provider.of<ProductList>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido'),
      ),
      body: FutureBuilder(
        future: productProvider.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar produtos!',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final allProducts = snapshot.data!;

            // Calcular o preço total do pedido
            final totalPrice = OrderUtils.getTotalPrice(context, order);

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: order.items.length,
                    separatorBuilder: (ctx, index) => Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    itemBuilder: (ctx, index) {
                      final cartItem = order.items[index];
                      final product = allProducts.firstWhere(
                        (prod) => prod.id == cartItem.productId,
                      );

                      return ListTile(
                        leading: Image.network(
                          product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.title),
                        subtitle: Text('Quantidade: ${cartItem.quantity}'),
                        trailing: Text(
                          'R\$ ${(product.price * cartItem.quantity).toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey.shade200,
                  child: Text(
                    'Preço total: R\$ ${totalPrice.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Nenhum produto encontrado para este pedido.'),
            );
          }
        },
      ),
    );
  }
}
