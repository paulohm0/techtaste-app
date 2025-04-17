import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/model/dish.dart';
import 'package:techtaste_app/ui/_core/bag_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BagProvider bagProvider = Provider.of<BagProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Carrinhos de Compras'),
        actions: [
          TextButton(
              onPressed: () {
                bagProvider.clearBag();
              },
              child: const Text('Limpar')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Pedidos',
                textAlign: TextAlign.center,
              ),
              Column(
                children: List.generate(
                  bagProvider.getMapByAmount().keys.length,
                  (index) {
                    Dish dish =
                        bagProvider.getMapByAmount().keys.toList()[index];
                    return ListTile(
                      leading:
                          Image.asset('assets/dishes/default.png', width: 98),
                      title: Text(dish.name),
                      subtitle: Text('R\$ ${dish.price.toStringAsFixed(2)}'),
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
                            bagProvider.getMapByAmount()[dish].toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
