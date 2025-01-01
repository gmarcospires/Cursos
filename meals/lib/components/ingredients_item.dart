import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class IngredientsItem extends StatelessWidget {
  final Meal meal;
  final int idx;

  const IngredientsItem({
    super.key,
    required this.meal,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              meal.ingredients[idx],
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
