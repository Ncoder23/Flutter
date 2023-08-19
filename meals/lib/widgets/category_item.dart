import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(this.cat, this.availableMeals, {super.key});
  final Category cat;
  final List<Meal> Function() availableMeals;
  void _onTap(BuildContext ctx) {
    final List<Meal> filteredMeals = availableMeals().where((element) {
      if (element.categories.contains(cat.id)) {
        return true;
      }
      return false;
    }).toList();
    Navigator.of(ctx).push(MaterialPageRoute(builder: (context) {
      return MealsScreen(
        txt: cat.title,
        meals: filteredMeals,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [cat.color.withOpacity(0.5), cat.color.withOpacity(0.9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // height: 100,
        // width: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cat.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
