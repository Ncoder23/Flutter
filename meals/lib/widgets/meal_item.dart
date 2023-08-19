import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_detail.dart';
import 'package:meals/widgets/meal_item_info.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem(this.meal, {super.key});
  final Meal meal;
  String get AffordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  String get ComplexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  void onMealTap(BuildContext ctx, Meal meal) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => onMealTap(context, meal),
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.9)
                  ]),
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemInfo(
                          icon: Icons.alarm,
                          label: meal.duration.toString(),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MealItemInfo(
                          icon: Icons.attach_money,
                          label: AffordabilityText,
                        ),
                        SizedBox(width: 15),
                        MealItemInfo(
                          icon: Icons.work,
                          label: ComplexityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
