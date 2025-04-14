import 'package:flutter/material.dart';
import 'package:techtaste_app/ui/_core/app_theme.dart';
import 'package:techtaste_app/ui/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
