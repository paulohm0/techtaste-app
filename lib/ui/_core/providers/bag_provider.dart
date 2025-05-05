import 'package:flutter/widgets.dart';
import 'package:techtaste_app/model/dish.dart';

class BagProvider extends ChangeNotifier {
  final List<Dish> dishesOnBag = [];

  addAllDishes(List<Dish> dishes) {
    dishesOnBag.addAll(dishes);
    notifyListeners();
  }

  removeDishes(Dish dish) {
    dishesOnBag.remove(dish);
    notifyListeners();
  }

  clearBag() {
    dishesOnBag.clear();
    notifyListeners();
  }

  /// retorna um map informando quantas vezes
  /// os pratos foram selecionados
  Map<Dish, int> getMapByAmount() {
    Map<Dish, int> mapResult = {};
    for (Dish dish in dishesOnBag) {
      if (mapResult[dish] == null) {
        mapResult[dish] = 1;
      } else {
        mapResult[dish] = mapResult[dish]! + 1;
      }
    }
    return mapResult;
  }

  double getSumPrices() {
    double total = 0.0;
    for (Dish dish in dishesOnBag) {
      total += dish.price;
    }
    return total;
  }
}
