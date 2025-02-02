import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/excepitions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = [];

//Retornando um clone para não interferir na lista original
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  Future<void> loadProducts() async {
    final response =
        await http.get(Uri.parse('${Constants.productBaseUrl}.json'));
    if (response.body == 'null') {
      return;
    }
    _items.clear();
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      _items.add(Product(
        id: productId,
        name: productData['name'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite'],
      ));
    });
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.productBaseUrl}.json'),
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
      // print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final index = _items.indexWhere((prod) => prod.id == product.id);

      if (index >= 0) {
        final response = await http.patch(
          Uri.parse('${Constants.productBaseUrl}/${product.id}.json'),
          body: jsonEncode({
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }),
        );
        jsonDecode(response.body)['name'];

        _items[index] = product;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      rethrow;
    }
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

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);

    if (index >= 0) {
      final product = _items[index];

      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.productBaseUrl}/$id.json'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
            message: 'Não foi possível excluir o produto.',
            statusCode: response.statusCode);
      }
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
