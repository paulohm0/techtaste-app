import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/data/categories_data.dart';
import 'package:techtaste_app/data/restaurants_data.dart';
import 'package:techtaste_app/ui/_core/services/restaurant_recommender.dart';
import 'package:techtaste_app/ui/_core/theme/app_colors.dart';
import 'package:techtaste_app/ui/_core/widgets/app_bar.dart';
import 'package:techtaste_app/ui/home/viewmodel/home_view_model.dart';
import 'package:techtaste_app/ui/home/widgets/category_widget.dart';
import 'package:techtaste_app/ui/home/widgets/restaurant_widget.dart';
import 'package:techtaste_app/ui/restaurant/restaurant_recommended_by_ia.dart';

import '../../model/restaurant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    RestaurantsData restaurantData = Provider.of<RestaurantsData>(context);
    final homeViewModel = context.watch<HomeViewModel>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            drawer: const Drawer(),
            appBar: const CustomAppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  // atributo spacing, so foi adicionado no flutter na versao 3.27

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset('assets/logo.png', width: 200)),
                    const SizedBox(height: 32.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: homeViewModel.searchAIController,
                            minLines: 1,
                            maxLength: 36,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              counterText: "",
                              hintText: 'O que você quer comer ?',
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.mainColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.mainColor),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            // Verifico se o campo de pesquisa por restaurantes via IA está vazio,
                            // para evitar enviar uma request à API sem parâmetro.
                            onPressed: homeViewModel
                                        .searchAIController.text.isEmpty ||
                                    homeViewModel.isLoading
                                ? null
                                : () async {
                                    FocusScope.of(context).unfocus();
                                    homeViewModel.changeLoading();
                                    final response = await RestaurantRecommender
                                        .recommendRestaurant(homeViewModel
                                            .searchAIController.text);
                                    if (!context.mounted) return;
                                    homeViewModel.changeLoading();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return RestaurantRecommendedByIa(
                                          restaurantRecommended: response);
                                    }));
                                  },
                            icon: const Icon(
                              Icons.search,
                              color: AppColors.mainColor,
                            )),
                      ],
                    ),
                    const SizedBox(height: 48.0),
                    const Text(
                      'Escolha por categoria',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16.0),
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
                    const Text(
                      'Bem avaliados',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16.0),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: restaurantData.listRestaurant.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        Restaurant restaurant =
                            restaurantData.listRestaurant[index];
                        return RestaurantWidget(restaurant: restaurant);
                      },
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (homeViewModel.isLoading)
          Stack(
            children: [
              ModalBarrier(
                dismissible: false,
                color: Colors.black.withOpacity(0.5),
              ),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
      ],
    );
  }
}
