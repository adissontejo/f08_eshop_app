import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user_list.dart';
import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserList>(context, listen: true);

    return Drawer(
      backgroundColor: Colors.pink,
      child: Column(
        children: [
          AppBar(
            title: Text('Bem-vindo, ${userList.loggedUser?.name}!'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.pink,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Página Inicial',
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.food_bank),
            title: const Text(
              'Meus Produtos',
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.MANAGE_PRODUCTS);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text(
              'Meu Carrinho',
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.CART);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text(
              'Meus Pedidos',
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Sair',
            ),
            onTap: () {
              userList.logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.LOGIN, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
