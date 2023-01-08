import 'package:dicoding_restaurant_app/controller/home_search.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:dicoding_restaurant_app/widget/card_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSearchFragment extends GetView<HomeSearchController> {
  const HomeSearchFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeSearchController controller = Get.find<HomeSearchController>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(child: Container()),

          // title
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              right: 24,
              left: 24,
            ),
            child: Text(
              'Find a restaurant',
              style: TextStyle(
                fontSize: Get.textTheme.headline4!.fontSize,
                fontWeight: FontWeight.bold,
                color: Get.theme.colorScheme.onBackground,
              ),
            ),
          ),

          // subtitle
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 4,
            ),
            child: Text(
              'Search restaurants by name, category, and menu',
              style: TextStyle(
                color: Get.theme.colorScheme.onBackground.withOpacity(.64),
                fontSize: Get.textTheme.subtitle1!.fontSize,
              ),
            ),
          ),

          // search field
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
            ),
            child: TextField(
              focusNode: controller.focusNode,
              controller: controller.textEditingController,
              textInputAction: TextInputAction.search,
              onEditingComplete: () => controller.searchRestaurant(),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: () => controller.clearSearchField(),
                ),
                border: const OutlineInputBorder(),
                labelText: 'Write something',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
          ),

          _buildSearchResult(controller),
        ],
      ),
    );
  }

  Widget _buildSearchResult(HomeSearchController controller) {
    return Obx(
      () {
        var state = controller.resultState.value;
        if (state == ResultState.error) {
          return Text('error: ${controller.message}');
        } else if (state == ResultState.loading) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  'Looking for a restaurant...',
                  style: TextStyle(
                    fontSize: Get.textTheme.subtitle1!.fontSize,
                    color: Get.theme.colorScheme.onBackground.withOpacity(.64),
                  ),
                ),
              ],
            ),
          );
        } else if (state == ResultState.noData) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24),
            child: Text(
              'Restaurant not found',
              style: TextStyle(
                color: Get.theme.colorScheme.onBackground.withOpacity(.64),
                fontSize: Get.textTheme.subtitle1!.fontSize,
              ),
            ),
          );
        } else if (state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => CardRestaurant(
              isLast:
                  (index == (controller.restaurantSearchResult.founded - 1)),
              restaurant: Restaurant.fromMap(
                controller.restaurantSearchResult.restaurants[index],
              ),
            ),
            itemCount: controller.restaurantSearchResult.restaurants.length,
          );
        }

        return Container();
      },
    );
  }
}
