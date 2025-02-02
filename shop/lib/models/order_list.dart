import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items];

  Future<void> loadOrders() async {
    final response =
        await http.get(Uri.parse('${Constants.orderBaseUrl}.json'));
    if (response.body == 'null') {
      return;
    }
    _items.clear();
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((orderId, orderData) {
      _items.add(Order(
        id: orderId,
        total: orderData['total'],
        products: (orderData['products'] as List<dynamic>).map((item) {
          return CartItem(
            id: item['id'],
            productId: item['productId'],
            name: item['name'],
            quantity: item['quantity'],
            price: item['price'],
          );
        }).toList(),
        date: DateTime.parse(orderData['date']),
      ));
    });
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.orderBaseUrl}.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values
            .map((cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'name': cartItem.name,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                })
            .toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }
}
