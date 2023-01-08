import 'package:dicoding_restaurant_app/controller/home_list.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/data/model/result/restaurant_list_result.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/widget/card_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class HomeListFragment extends GetView<HomeListController> {
  const HomeListFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeListController controller = Get.find<HomeListController>();

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
              'Restaurant',
              style: TextStyle(
                fontSize: Get.textTheme.headline4!.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 16,
              top: 4,
            ),
            child: Text(
              'Here are some of the best restaurants we recommend for you!',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: Get.textTheme.subtitle1!.fontSize,
              ),
            ),
          ),

          // list restaurant
          Obx(() {
            var state = controller.resultState.value;

            if (state == ResultState.loading) {
              return _loading();
            } else if (state == ResultState.hasData) {
              return _listRestaurant(controller.restaurantListResult);
            } else if (state == ResultState.noData ||
                state == ResultState.error) {
              return _message(controller.message);
            }

            return Container();
          }),
        ],
      ),
    );
  }

  Widget _message(String message) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Text(
        message,
        style: TextStyle(
          fontSize: Get.textTheme.subtitle1!.fontSize,
          color: Get.theme.colorScheme.onBackground.withOpacity(.64),
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(
            'Loading restaurant data...',
            style: TextStyle(
              fontSize: Get.textTheme.subtitle1!.fontSize,
              color: Get.theme.colorScheme.onBackground.withOpacity(.64),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listRestaurant(RestaurantListResult result) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CardRestaurant(
          restaurant: result.restaurants[index],
          isLast: (index == (result.count - 1)),
        );
      },
      itemCount: result.count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
    );
  }
}
