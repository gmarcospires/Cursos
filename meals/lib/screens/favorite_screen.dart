import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoriteScreen(this.favoriteMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: favoriteMeals.isEmpty
          ? Center(
              child: Text('Nenhuma refeição favorita'),
            )
          : ListView.builder(
              itemCount: favoriteMeals.length,
              itemBuilder: (ctx, idx) {
                return MealItem(favoriteMeals[idx]);
              },
            ),
    );
  }
}
