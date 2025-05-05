import 'package:flutter/material.dart';
import 'package:techtaste_app/model/restaurant.dart';
import 'package:techtaste_app/ui/_core/widgets/app_bar.dart';

import '../home/widgets/restaurant_widget.dart';

class CategoryScreen extends StatelessWidget {
  final List<Restaurant> filteredRestaurants;
  final String category;
  const CategoryScreen(
      {super.key, required this.filteredRestaurants, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredRestaurants.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              Restaurant restaurant = filteredRestaurants[index];
              return RestaurantWidget(restaurant: restaurant);
            },
          ),
        ),
      ),
    );
  }
}
