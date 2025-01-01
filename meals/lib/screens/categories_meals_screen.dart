import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';

class CategoriesMealsScreen extends StatelessWidget {
  // final Category category;
  const CategoriesMealsScreen(
      // this.category,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;
    final categoryMeals = dummyMeals.where((meal) {
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
