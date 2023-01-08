import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/pages/home.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_list.dart';
import 'package:dicoding_restaurant_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff386a20),
      ),
      initialRoute: SplashPage.route,
      routes: {
        SplashPage.route: (context) => const SplashPage(),
        HomePage.route: (context) => const HomePage(),
        RestaurantListPage.route: (context) => const RestaurantListPage(),
        RestaurantDetailPage.route: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
