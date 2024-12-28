import 'package:flutter/material.dart';
import 'package:meals/components/category_item.dart';
import 'package:meals/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lets Cook?'),
      ),
      body: SafeArea(
        child: GridView(
          padding: const EdgeInsets.all(25),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, // maximo de largura de cada item
            childAspectRatio: 3 / 2, // proporção de cada item
            crossAxisSpacing: 20, // espaço entre os itens
            mainAxisSpacing: 20, // espaço entre as linhas
          ),
          children: dummyCategories.map((cat) {
            return CategoryItem(
              cat,
              key: ValueKey(cat.id),
            );
          }).toList(),
        ),
      ),
    );
  }
}
