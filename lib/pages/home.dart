import 'package:dicoding_restaurant_app/controller/home.dart';
import 'package:dicoding_restaurant_app/fragments/home_list.dart';
import 'package:dicoding_restaurant_app/fragments/home_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  static String route = '/home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.navigationBarIndex.value,
          onDestinationSelected: (value) =>
              controller.changeNavigationBarIndex(value),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.restaurant_rounded),
              label: 'Restaurant',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
          ],
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        children: const [
          HomeListFragment(),
          HomeSearchFragment(),
        ],
        onPageChanged: (value) => controller.changeNavigationBarIndex(value),
      ),
    );
  }
}
