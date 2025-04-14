import 'package:flutter/material.dart';
import 'package:techtaste_app/ui/_core/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Image.asset('assets/banners/banner_splash.png'),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 250,
                  ),
                  const SizedBox(height: 24),
                  const Column(
                    children: [
                      Text(
                        'Um parceiro inovador para a sua',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Text(
                        'melhor experiência culinária !',
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Bora !',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
