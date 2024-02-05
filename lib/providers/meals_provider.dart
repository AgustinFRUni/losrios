import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losrios/data/dummy_data.dart';
import 'package:losrios/models/meal.dart';

class MealsNotifier extends StateNotifier<List<Meal>> {
  MealsNotifier() : super([...dummyMeals]);

  void toggleMealState(Meal meal) {
    List<Meal> mealList = [];

    for (final mealItem in state) {
      if(mealItem == meal){
        if (mealItem.state == 'activo') {
        var newMealItem = Meal(
            id: mealItem.id,
            category: mealItem.category,
            title: mealItem.title,
            imageUrl: mealItem.imageUrl,
            price: mealItem.price,
            description: mealItem.description,
            state: 'inactivo');
        mealList.add(newMealItem);
      } else {
        var newMealItem = Meal(
            id: mealItem.id,
            category: mealItem.category,
            title: mealItem.title,
            imageUrl: mealItem.imageUrl,
            price: mealItem.price,
            description: mealItem.description,
            state: 'activo');
        mealList.add(newMealItem);
      }
      }else{
        mealList.add(mealItem);
      }

      
    }
    state = [...mealList];
  }

  bool isActive(Meal meal){
    return state.firstWhere((element) => element.id == meal.id).state == 'activo' ? true : false; 

  }

  void addMeal(Meal meal) {
    List<Meal> mealList = [];  

    if(state.where((m) => m.id == meal.id).isEmpty){
      state = [...state, meal];
    }else{
      for (final mealItem in state){
        if(mealItem.id == meal.id){
          mealList.add(meal);
        } else{
          mealList.add(mealItem);
        }
      }

      state = [...mealList];
    }
  }
}

// final mealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
//   return MealsNotifier();
// });

final mealsProvider =
    StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
  return MealsNotifier();
});

// final mealsProvider = Provider((ref) {
//   return
  
  
//    dummyMeals;

   
// }

// );
