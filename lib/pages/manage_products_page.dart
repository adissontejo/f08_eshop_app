import 'package:f08_eshop_app/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/product_grid.dart';
import '../model/product_list.dart';
import '../utils/app_routes.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ManageProductsPage extends StatefulWidget {
  ManageProductsPage({Key? key}) : super(key: key);

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Meus Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM,
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ProductGrid(
        showOnlyOwned: true,
      ),
    );
  }
}
