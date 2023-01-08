import 'package:dicoding_restaurant_app/controller/home_list.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/data/model/result/restaurant_list_result.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';

class HomeListFragment extends GetView<HomeListController> {
  const HomeListFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    final HomeListController controller = Get.put(HomeListController());

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
            var state = controller.resultState;
            switch (state.value) {
              case ResultState.loading:
                return CircularProgressIndicator();

              case ResultState.noData:
                return Text(controller.message);

              case ResultState.hasData:
                return _listRestaurant(controller.restaurantListResult);

              case ResultState.error:
                return Text(controller.message);
            }
          }),
        ],
      ),
    );
  }

  Widget _listRestaurant(RestaurantListResult result) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _listItemRestaurant(
          result.restaurants[index],
          (index == (result.count - 1)),
        );
      },
      itemCount: result.count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
    );
  }

  Widget _listItemRestaurant(Restaurant restaurant, bool isLast) {
    return Container(
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: isLast ? 8 : 0,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: Get.size.height / 4,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Text(
                  restaurant.name,
                  style: TextStyle(
                    fontSize: Get.textTheme.headline6!.fontSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Text(
                  restaurant.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Get.textTheme.subtitle1!.fontSize,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // location
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Colors.indigo,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      restaurant.city,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),

              // rating
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${restaurant.rating}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
