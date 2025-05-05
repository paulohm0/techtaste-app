import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/data/restaurants_data.dart';
import 'package:techtaste_app/ui/_core/theme/app_colors.dart';
import 'package:techtaste_app/ui/category/category_screen.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lightBackgroundColor,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          final filteredRestaurants = context
              .read<RestaurantsData>()
              .filterRestaurantsByCategory(category);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CategoryScreen(
                  filteredRestaurants: filteredRestaurants,
                  category: category,
                );
              },
            ),
          );
        },
        child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/categories/${category.toLowerCase()}.png',
                  height: 48),
              const SizedBox(height: 8.0),
              Text(
                category,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
