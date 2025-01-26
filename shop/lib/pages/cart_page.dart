import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 10),
                    Chip(
                      label: Text(
                        'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headlineSmall
                              ?.color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Provider.of<OrderList>(context, listen: false)
                            .addOrder(cart);
                        cart.clear();
                      },
                      child: const Text('COMPRAR'),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, i) {
                  return CartItemWidget(cartItem: items[i]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
