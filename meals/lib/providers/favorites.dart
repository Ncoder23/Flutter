import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavirotesNotifer extends StateNotifier<List<Meal>> {
  FavirotesNotifer() : super([]); // to initialize the state of data

  bool toggleFavorite(Meal meal) {
    bool isExists = state.contains(meal);
    if (isExists) {
      state = state.where((ml) {
        if (ml.id != meal.id) {
          return true;
        }
        return false;
      }).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favProvider = StateNotifierProvider<FavirotesNotifer, List<Meal>>(
    (ref) => FavirotesNotifer());
