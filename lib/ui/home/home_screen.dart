import 'package:flutter/material.dart';
import 'package:techtaste_app/data/categories_data.dart';
import 'package:techtaste_app/ui/home/widgets/category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
            Row(
              children: List.generate(
                CategoriesData.listCategories.length,
                (index) {
                  return CategoryWidget(
                    category: CategoriesData.listCategories[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 32.0),
            Image.asset('assets/banners/banner_promo.png'),
            const SizedBox(height: 32.0),
            const Text('Bem avaliados'),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
