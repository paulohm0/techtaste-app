import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/model/dish.dart';
import 'package:techtaste_app/ui/_core/providers/bag_provider.dart';
import 'package:techtaste_app/ui/_core/theme/app_colors.dart';
import 'package:techtaste_app/ui/checkout/check_delivery_screen.dart';

class CheckOrderScreen extends StatelessWidget {
  const CheckOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BagProvider bagProvider = Provider.of<BagProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Carrinhos de Compras'),
        actions: [
          bagProvider.dishesOnBag.isEmpty
              ? const SizedBox()
              : TextButton(
                  onPressed: () {
                    bagProvider.clearBag();
                  },
                  child: const Text('Limpar')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: bagProvider.dishesOnBag.isEmpty
            ? Center(
                child: Image.asset(
                  'assets/others/empty_cart.png',
                  scale: 3.0,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Pedidos',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // dessa forma o scroll ocupa apenas 50% de tela
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          bagProvider.getMapByAmount().keys.length,
                          (index) {
                            Dish dish = bagProvider
                                .getMapByAmount()
                                .keys
                                .toList()[index];
                            return ListTile(
                              leading: Image.asset('assets/dishes/default.png',
                                  width: 98),
                              title: Text(dish.name),
                              subtitle: Text(
                                  'R\$ ${(dish.price * bagProvider.getMapByAmount()[dish]!).toStringAsFixed(2)}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        bagProvider.removeDishes(dish);
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                      )),
                                  Text(
                                    bagProvider
                                        .getMapByAmount()[dish]
                                        .toString(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        bagProvider.addAllDishes([dish]);
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                      )),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.greyBackground,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Order Total',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black),
                                ),
                                Text(
                                  'R\$ ${bagProvider.getSumPrices().toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black),
                                ),
                              ],
                            ),
                            Text(
                              '${bagProvider.dishesOnBag.length} items',
                              style: const TextStyle(
                                  color: AppColors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FloatingActionButton(
                      backgroundColor: AppColors.mainColor,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Fazer Pedido',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black),
                          ),
                          SizedBox(width: 8.0),
                          Icon(
                            Icons.shopping_basket,
                            color: AppColors.black,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CheckDeliveryScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
