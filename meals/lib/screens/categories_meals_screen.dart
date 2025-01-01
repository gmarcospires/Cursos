import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;

  const CategoriesMealsScreen(this.meals, {super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;
    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: category.color,
        title: Text(
          category.title,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, idx) {
            return MealItem(categoryMeals[idx]);
          },
        ),
      ),
    );
  }
}