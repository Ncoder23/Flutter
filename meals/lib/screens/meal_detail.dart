import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen(this.meal, {super.key});
  final Meal meal;

  Widget build(BuildContext context, WidgetRef ref) {
    List<Meal> favirotes = ref.watch(favProvider);
    bool isFavrote = favirotes.contains(meal);
    //print(widget.isFav);
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                bool wasAdded =
                    ref.read(favProvider.notifier).toggleFavorite(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(wasAdded ? 'Meal Added' : 'Meal Removed'),
                    duration: const Duration(
                      seconds: 1,
                    ),
                  ),
                );
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) =>
                    RotationTransition(turns: animation, child: child),
                child: Icon(
                  isFavrote ? Icons.star : Icons.star_border,
                  key: ValueKey(isFavrote),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Ingredients",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 26,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (final step in meal.ingredients)
                  Text(
                    step,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Steps",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 26,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < meal.steps.length; i++)
                  ListTile(
                    leading: Text(
                      (i + 1).toString(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 20,
                          ),
                    ),
                    title: Text(
                      meal.steps[i],
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 20,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}
