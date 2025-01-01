import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class StepsItem extends StatelessWidget {
  final Meal meal;
  final int idx;

  const StepsItem({
    super.key,
    required this.meal,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          child: Text('${idx + 1}'),
        ),
        title: Text(
          meal.steps[idx],
        ),
      ),
    );
  }
}
