import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var navigationBarIndex = 0.obs;
  final PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;

  void changeNavigationBarIndex(value) {
    if (navigationBarIndex.value != value) {
      navigationBarIndex.value = value;
      _pageController.animateToPage(
        value,
        duration: const Duration(
          milliseconds: 250,
        ),
        curve: Curves.linear,
      );
    }
  }
}
