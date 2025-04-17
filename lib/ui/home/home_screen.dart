import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/data/categories_data.dart';
import 'package:techtaste_app/data/restaurants_data.dart';
import 'package:techtaste_app/ui/home/widgets/category_widget.dart';
import 'package:techtaste_app/ui/home/widgets/restaurant_widget.dart';

import '../../model/restaurant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RestaurantsData restaurantData = Provider.of<RestaurantsData>(context);
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            // atributo spacing, so foi adicionado no flutter na versao 3.27
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/logo.png', width: 147)),
              const SizedBox(height: 32.0),
              const Text('Boas-Vindas !'),
              const SizedBox(height: 32.0),
              TextFormField(),
              const SizedBox(height: 32.0),
              const Text('Escolha por categoria'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 8.0,
                  children: List.generate(
                    CategoriesData.listCategories.length,
                    (index) {
                      return CategoryWidget(
                        category: CategoriesData.listCategories[index],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Image.asset('assets/banners/banner_promo.png'),
              const SizedBox(height: 32.0),
              const Text('Bem avaliados'),
              const SizedBox(height: 16.0),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: restaurantData.listRestaurant.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  Restaurant restaurant = restaurantData.listRestaurant[index];
                  return RestaurantWidget(restaurant: restaurant);
                },
              ),
              const SizedBox(height: 64.0),
            ],
          ),
        ),
      ),
    );
  }
}
