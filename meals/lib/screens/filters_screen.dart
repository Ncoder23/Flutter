import 'package:flutter/material.dart';
import 'package:meals/screens/toggle_screen.dart';
import 'package:meals/models/meal.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this.currFilters, {super.key});
  final Map<Filters, bool> currFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("select your preference"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SwitchListTile(
                value: widget.currFilters[Filters.isVegetarian]!,
                onChanged: (value) {
                  setState(() {
                    widget.currFilters[Filters.isVegetarian] = value;
                  });
                },
                title: Text(
                  "Vegeterian",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              SwitchListTile(
                value: widget.currFilters[Filters.isVegan]!,
                onChanged: (value) {
                  setState(() {
                    widget.currFilters[Filters.isVegan] = value;
                  });
                },
                title: Text(
                  "Vegan",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              SwitchListTile(
                value: widget.currFilters[Filters.isGluteneFree]!,
                onChanged: (value) {
                  setState(() {
                    widget.currFilters[Filters.isGluteneFree] = value;
                  });
                },
                title: Text(
                  "Glutene Free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              SwitchListTile(
                value: widget.currFilters[Filters.isLactoseFree]!,
                onChanged: (value) {
                  setState(() {
                    widget.currFilters[Filters.isLactoseFree] = value;
                  });
                },
                title: Text(
                  "Lactose Free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              )
            ],
          ),
        ));
  }
}
