import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widgets/category_item.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(this.availableMeals, {super.key});
  final List<Meal> Function() availableMeals;
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        //crossAxisSpacing: 16,
      ),
      children: [
        for (final cat in availableCategories) CategoryItem(cat, availableMeals)
      ],
    );
  }
}
