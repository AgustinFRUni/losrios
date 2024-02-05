import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losrios/providers/meals_provider.dart';



class FiltersNotifier extends StateNotifier<bool> {
  FiltersNotifier()
      : super(false);


  void setFilter(bool isActive) {
    //state[filter] = isActive; //not allowed! => mutating state
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, bool>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  ref.watch(filtersProvider);

  return meals.where((meal) {
    return meal.state == 'activo';
  }).toList();
});
