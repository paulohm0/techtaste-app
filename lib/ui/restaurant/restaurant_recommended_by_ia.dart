import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/data/restaurants_data.dart';
import 'package:techtaste_app/model/restaurant.dart';
import 'package:techtaste_app/ui/_core/widgets/app_bar.dart';
import 'package:techtaste_app/ui/home/widgets/restaurant_widget.dart';

class RestaurantRecommendedByIa extends StatelessWidget {
  final String restaurantRecommended;
  const RestaurantRecommendedByIa(
      {super.key, required this.restaurantRecommended});

  @override
  Widget build(BuildContext context) {
    final List<String> listRestaurantRecommended = restaurantRecommended
        .split(',')
        .map((restaurant) => restaurant.trim())
        .toList();
    final restaurantData = Provider.of<RestaurantsData>(context, listen: false);
    final List<Restaurant> allRestaurants = restaurantData.listRestaurant;
    final List<Restaurant> recommendedRestaurants =
        allRestaurants.where((restaurant) {
      return listRestaurantRecommended.contains(restaurant.id.toString());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Sugestões'),
      body: recommendedRestaurants.isEmpty
          ? const Center(child: Text('Nenhum restaurante encontrado.'))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recommendedRestaurants.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final restaurant = recommendedRestaurants[index];
                    return RestaurantWidget(restaurant: restaurant);
                  },
                ),
              ),
            ),
    );
  }
}
