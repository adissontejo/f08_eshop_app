import 'package:f08_eshop_app/components/app_drawer.dart';
import 'package:f08_eshop_app/model/order_list.dart';
import 'package:f08_eshop_app/model/user_list.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';
import 'package:f08_eshop_app/utils/order_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f08_eshop_app/model/order.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderList>(context, listen: false);
    final userList = Provider.of<UserList>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Lista de Pedidos'),
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder<List<Order>>(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar pedidos!',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Order> orders = snapshot.data!
                .where(
                    (order) => order.creatorUserId == userList.loggedUser!.id)
                .toList();
            return ListView.separated(
              itemCount: orders.length,
              separatorBuilder: (ctx, index) => Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              itemBuilder: (ctx, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Pedido #${order.id}'),
                  subtitle: Text(
                      '${order.items.length} item(s) | R\$ ${OrderUtils.getTotalPrice(context, order).toStringAsFixed(2)}'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.ORDER_DETAILS, arguments: order);
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text('Nenhum pedido encontrado.'),
            );
          }
        },
      ),
    );
  }
}
