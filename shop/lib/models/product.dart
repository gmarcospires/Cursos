import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/excepitions/http_exception.dart';
import 'package:shop/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    _toggleFavorite();

    try {
      final response = await http.patch(
        Uri.parse('${Constants.productBaseUrl}/$id.json'),
        body: jsonEncode({
          'isFavorite': isFavorite,
        }),
      );

      if (response.statusCode >= 400) {
        throw HttpException(
            message: 'Não foi possível excluir o produto.',
            statusCode: response.statusCode);
      }
    } catch (error) {
      _toggleFavorite();
    }
  }
}
