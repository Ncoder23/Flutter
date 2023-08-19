import 'package:flutter/material.dart';
import 'package:meals/providers/favorites.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filters {
  isVegan,
  isVegetarian,
  isLactoseFree,
  isGluteneFree,
}

class ToggleScreen extends ConsumerStatefulWidget {
  const ToggleScreen({super.key});

  @override
  ConsumerState<ToggleScreen> createState() => _ToggleScreenState();
}

class _ToggleScreenState extends ConsumerState<ToggleScreen> {
  int _currPageIdx = 0;
  final Map<Filters, bool> _initialFilters = {
    Filters.isVegan: false,
    Filters.isLactoseFree: false,
    Filters.isGluteneFree: false,
    Filters.isVegetarian: false,
  };

  void _switchScreen(String? st) {
    Navigator.of(context).pop();
    if (st == "filters") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) {
          return FiltersScreen(_initialFilters);
        }),
      );
    }
  }

  void _switchBottom(int index) {
    setState(() {
      _currPageIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> meals = ref.watch(mealsProvider);
    List<Meal> _availableMeals() {
      return meals.where((ml) {
        if (ml.isGlutenFree != _initialFilters[Filters.isGluteneFree]) {
          return false;
        }
        if (ml.isVegan != _initialFilters[Filters.isVegan]) {
          return false;
        }
        if (ml.isVegetarian != _initialFilters[Filters.isVegetarian]) {
          return false;
        }
        if (ml.isLactoseFree != _initialFilters[Filters.isLactoseFree]) {
          return false;
        }
        return true;
      }).toList();
    }

    Widget _activeScreen = CategoriesScreen(_availableMeals);
    String pageTitle = 'Select Your Category';
    List<Meal> favMeals = ref.watch(favProvider);
    if (_currPageIdx == 1) {
      pageTitle = 'Favirotes';
      _activeScreen = MealsScreen(
        meals: favMeals,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: _activeScreen,
      drawer: Drawer(
        elevation: 4,
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.background.withOpacity(0.5),
                    Theme.of(context).colorScheme.background.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _switchScreen(null);
                },
                child: ListTile(
                  leading: Icon(Icons.restaurant),
                  title: Text(
                    "Menu",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 24,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _switchScreen('filters');
                },
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    "Filters",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 24,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _switchBottom,
        currentIndex: _currPageIdx,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
            ),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_outlined,
            ),
            label: "Favirotes",
          ),
        ],
      ),
    );
  }
}
