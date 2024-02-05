import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losrios/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Map<Meal, int>>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    var favoriteMeal = state.where((e) => e.containsKey(meal));
    final mealIsFavorite = favoriteMeal.isNotEmpty;
    
    if (mealIsFavorite) {
      state = state.where((m) => !m.containsKey(meal)).toList();
      return false;
    } else {
      state = [...state, <Meal, int>{meal: 1}]; 
      return true;
    }
  }

  bool isMealFavorite(Meal meal) {
    var favoriteMeal = state.where((e) => e.containsKey(meal));
    final mealIsFavorite = favoriteMeal.isNotEmpty;
    
    return mealIsFavorite;
  }

  void addMeal(Meal meal) {
    List<Map<Meal, int>> orderList = [];  

    for(final orderItem in state){
      if (orderItem.containsKey(meal) && orderItem.entries.first.value < 100){
        var newOrderItem = <Meal,int>{orderItem.entries.first.key: orderItem.entries.first.value + 1};
        orderList.add(newOrderItem);
      }else{
        orderList.add(orderItem);
      }
    }
      state = [...orderList]; 
  }

  void removeMeal(Meal meal) {
    List<Map<Meal, int>> orderList = [];  

    for(final orderItem in state){
      if (orderItem.containsKey(meal) && orderItem.entries.first.value > 1){
        var newOrderItem = <Meal,int>{orderItem.entries.first.key: orderItem.entries.first.value - 1};
        orderList.add(newOrderItem);
      }else{
        orderList.add(orderItem);
      }
    }
      state = [...orderList]; 
  }

  double totalPrice() {
    double totalPrice = 0;
    if (state.isNotEmpty){
      for(final orderItem in state){
      totalPrice += orderItem.entries.first.key.price * orderItem.entries.first.value;
      }
    }
    return totalPrice;
  }

  String getNumber(){
    return "543794265038";
  }

  String getOrder(){
    String order = '';

    for(final orderItem in state){
      order = "$order------------------------------------------\n${orderItem.keys.first.title[0].toUpperCase()}${orderItem.keys.first.title.substring(1).toLowerCase()}\nCant: ${orderItem.values.first.toString()}\n";
    }
    
    return order;
  }

  
}
  

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Map<Meal,int>>>((ref) {
  return FavoriteMealsNotifier();
});
