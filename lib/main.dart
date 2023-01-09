import 'package:dicoding_restaurant_app/controller/bindings/app_bindings.dart';
import 'package:dicoding_restaurant_app/pages/home.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_add_review.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff386a20),
      ),
      initialRoute: SplashPage.route,
      initialBinding: AppBindings(),
      routes: {
        SplashPage.route: (context) => const SplashPage(),
        HomePage.route: (context) => const HomePage(),
        RestaurantDetailPage.route: (context) => const RestaurantDetailPage(),
        RestaurantAddReviewPage.route: (context) =>
            const RestaurantAddReviewPage(),
      },
    );
  }
}
