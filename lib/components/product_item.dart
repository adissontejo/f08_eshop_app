import 'package:f08_eshop_app/model/cart.dart';
import 'package:f08_eshop_app/model/cart_item.dart';
import 'package:f08_eshop_app/model/product.dart';
import 'package:f08_eshop_app/model/product_list.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final bool editorView;

  const ProductItem({this.editorView = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Produto do Provider
    final product = context.watch<Product>();

    // Carrinho do Provider
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: editorView
              ? IconButton(
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.PRODUCT_FORM,
                      arguments: product),
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).colorScheme.secondary,
                )
              : IconButton(
                  onPressed: () async {
                    product.toggleFavorite();
                    Provider.of<ProductList>(context, listen: false)
                        .updateProduct(product);
                  },
                  icon: Consumer<Product>(
                    builder: (context, product, child) => Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: editorView
              ? IconButton(
                  onPressed: () =>
                      Provider.of<ProductList>(context, listen: false)
                          .removeProduct(product),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.secondary,
                )
              : IconButton(
                  onPressed: () {
                    // Adiciona ao carrinho
                    cart.add(CartItem(productId: product.id, quantity: 1));

                    // Exibe a mensagem de confirmação
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${product.title} foi adicionado ao carrinho!'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'DESFAZER',
                          onPressed: () {
                            cart.remove(cart.items.length -
                                1); // Remove o último item adicionado
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  color: Theme.of(context).colorScheme.secondary,
                ),
        ),
      ),
    );
  }
}
