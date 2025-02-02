import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/excepitions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final alertScaffold = ScaffoldMessenger.of(context);
    final productProvider = Provider.of<ProductList>(context, listen: false);

    return ListTile(
      title: Text(product.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.productForm, arguments: product);
              },
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir?'),
                    content: Text('Quer remover ${product.name}?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: const Text(
                          'Não',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          // Provider.of<ProductList>(context, listen: false)
                          //     .deleteProduct(product.id);
                          Navigator.of(ctx).pop(true);
                        },
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                ).then((value) async {
                  if (value ?? false) {
                    try {
                      await productProvider.deleteProduct(product.id);
                    } on HttpException catch (error) {
                      alertScaffold.showSnackBar(
                        SnackBar(
                          content: Text(
                            error.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                });
              },
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
