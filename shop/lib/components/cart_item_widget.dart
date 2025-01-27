import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
          size: 40,
        ),
      ),
      onDismissed: (_) => {
        Provider.of<Cart>(context, listen: false)
            .removeItem(cartItem.productId),
      },
      confirmDismiss: (_) {
        return showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Tem certeza?'),
                  content: const Text('Quer remover o item do carrinho?'),
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
                        Navigator.of(ctx).pop(true);
                      },
                      child: const Text('Sim'),
                    ),
                  ],
                ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('R\$ ${cartItem.price}'),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('R\$ ${cartItem.price * cartItem.quantity}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }
}
