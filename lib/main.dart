import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste_app/data/restaurants_data.dart';
import 'package:techtaste_app/ui/_core/providers/bag_provider.dart';
import 'package:techtaste_app/ui/_core/theme/app_theme.dart';
import 'package:techtaste_app/ui/checkout/viewmodel/check_delivery_view_model.dart';
import 'package:techtaste_app/ui/home/viewmodel/home_view_model.dart';
import 'package:techtaste_app/ui/splash/splash_screen.dart';

class Focus extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RestaurantsData restaurantsData = RestaurantsData();
  await restaurantsData.getRestaurant();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => restaurantsData),
        ChangeNotifierProvider(create: (context) => BagProvider()),
        ChangeNotifierProvider(create: (context) => CheckDeliveryViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [Focus()],
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
