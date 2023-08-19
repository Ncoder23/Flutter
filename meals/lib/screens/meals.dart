import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';
import 'package:meals/models/meal.dart';

class MealsScreen extends StatelessWidget {
  MealsScreen({this.txt, required this.meals, super.key});
  final String? txt;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(meals[index]),
      );
    }

    if (txt == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(txt!),
      ),
      body: content,
    );
  }
}
