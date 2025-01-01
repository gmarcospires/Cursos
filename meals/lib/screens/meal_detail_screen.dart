import 'package:flutter/material.dart';
import 'package:meals/components/ingredients_item.dart';
import 'package:meals/components/steps_item.dart';
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;

  const MealDetailScreen(this.onToggleFavorite, this.isFavorite, {super.key});

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _createSectionContainer(BuildContext context, Widget child) {
    return Container(
      width: 330,
      height: 250,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: category.color,
        title: Text(
          meal.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              _createSectionTitle(context, 'Ingredientes'),
              _createSectionContainer(
                context,
                ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (ctx, idx) {
                    return IngredientsItem(meal: meal, idx: idx);
                  },
                ),
              ),
              _createSectionTitle(context, 'Preparo'),
              _createSectionContainer(
                context,
                ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (ctx, idx) {
                    return StepsItem(meal: meal, idx: idx);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onToggleFavorite(meal),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          isFavorite(meal) ? Icons.star : Icons.star_border,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
