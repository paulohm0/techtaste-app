import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/model/dish.dart';
import 'package:techtaste_app/model/restaurant.dart';
import 'package:techtaste_app/ui/_core/providers/bag_provider.dart';
import 'package:techtaste_app/ui/_core/widgets/app_bar.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: restaurant.name),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Image.asset(
              'assets/${restaurant.imagePath}',
              width: 128,
            ),
            const SizedBox(height: 32),
            const Text(
              'Mais pedidos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Column(
                children: List.generate(restaurant.dishes.length, (index) {
              Dish dish = restaurant.dishes[index];
              return ListTile(
                leading: Image.asset('assets/dishes/default.png', width: 98),
                title: Text(dish.name),
                subtitle: Text('R\$ ${dish.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  onPressed: () {
                    context.read<BagProvider>().addAllDishes([dish]);
                  },
                  icon: const Icon(Icons.add),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}
