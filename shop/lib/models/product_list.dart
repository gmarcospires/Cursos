import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  final _baseUrl = 'https://shop-flutter-9775c-default-rtdb.firebaseio.com';

//Retornando um clone para não interferir na lista original
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/products.json'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );

      final id = jsonDecode(response.body)['name'];

      _items.add(Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ));
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) {
    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> saveProduct(Map<String, Object> map) {
    bool hasId = map.containsKey('id') && map['id'] != null;

    final product = Product(
      id: hasId ? map['id'].toString() : Random().nextDouble().toString(),
      name: map['name'].toString(),
      description: map['description'].toString(),
      price: double.parse(map['price'].toString()),
      imageUrl: map['imageUrl'].toString(),
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);

    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }

  int get itemsCount {
    return _items.length;
  }

  // bool _showFavoriteOnly = false;

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }
}
