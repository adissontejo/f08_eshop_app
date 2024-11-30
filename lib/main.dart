import 'package:f08_eshop_app/model/cart.dart';
import 'package:f08_eshop_app/model/order_list.dart';
import 'package:f08_eshop_app/model/user_list.dart';
import 'package:f08_eshop_app/pages/cart_page.dart';
import 'package:f08_eshop_app/pages/login_page.dart';
import 'package:f08_eshop_app/pages/manage_products_page.dart';
import 'package:f08_eshop_app/pages/order_details_page.dart';
import 'package:f08_eshop_app/pages/orders_page.dart';
import 'package:f08_eshop_app/pages/product_detail_page.dart';
import 'package:f08_eshop_app/pages/product_form_page.dart';
import 'package:f08_eshop_app/pages/products_overview_page.dart';
import 'package:f08_eshop_app/pages/register_page.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserList(),
      child: ChangeNotifierProvider(
        create: (context) => ProductList(),
        child: ChangeNotifierProvider(
          create: (context) => Cart(),
          child: ChangeNotifierProvider(
            create: (context) => OrderList(),
            child: MaterialApp(
              title: 'Minha Loja',
              theme: ThemeData(
                  fontFamily: 'Lato',
                  colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                      primary: Colors.pink, secondary: Colors.orangeAccent)),
              routes: {
                AppRoutes.LOGIN: (ctx) => const LoginPage(),
                AppRoutes.REGISTER: (ctx) => RegisterPage(),
                AppRoutes.HOME: (ctx) => ProductsOverviewPage(),
                AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
                AppRoutes.PRODUCT_FORM: (context) => const ProductFormPage(),
                AppRoutes.CART: (ctx) => const CartPage(),
                AppRoutes.ORDERS: (ctx) => const OrdersPage(),
                AppRoutes.ORDER_DETAILS: (ctx) => const OrderDetailsPage(),
                AppRoutes.MANAGE_PRODUCTS: (ctx) => ManageProductsPage(),
              },
              initialRoute: AppRoutes.LOGIN,
              debugShowCheckedModeBanner: false,
            ),
          ),
        ),
      ),
    );
  }
}
