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
    final HomeController controller = Get.put(HomeController());
    final pages = [
      const HomeListFragment(),
      const HomeSearchFragment(),
    ];

    return Scaffold(
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
      body: Obx(
        () => pages[controller.navigationBarIndex.value],
      ),
    );
  }
}
