import 'package:exam_adv/screens/home/home_page.dart';
import 'package:exam_adv/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () => Get.offNamed(AppRoutes.home),
    );
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Image.network(
          'https://cdn5.f-cdn.com/contestentries/157322/13929033/54e3207f255dd_thumb900.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
