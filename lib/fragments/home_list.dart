import 'package:dicoding_restaurant_app/controller/home_list.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/data/model/result/restaurant_list_result.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                return _loading();

              case ResultState.hasData:
                return _listRestaurant(controller.restaurantListResult);

              case ResultState.noData:
              case ResultState.error:
                return _message(controller.message);
            }
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
        elevation: 0,
        color: Get.theme.colorScheme.surfaceVariant,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => Get.toNamed(
            RestaurantDetailPage.route,
            arguments: {'id': restaurant.id},
          ),
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
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                  fit: BoxFit.cover,
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
                    color: Get.theme.colorScheme.onSurfaceVariant,
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
                    color:
                        Get.theme.colorScheme.onSurfaceVariant.withOpacity(.64),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // location
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 24,
                      color: Get.theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      restaurant.city,
                      style: TextStyle(
                        color: Get.theme.colorScheme.onSurfaceVariant
                            .withOpacity(.64),
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
                    RatingBar.builder(
                      glow: false,
                      ignoreGestures: true,
                      itemSize: 24,
                      unratedColor: Get.theme.colorScheme.onSurfaceVariant
                          .withOpacity(.24),
                      initialRating: restaurant.rating,
                      itemCount: 5,
                      allowHalfRating: true,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {},
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${restaurant.rating}',
                      style: TextStyle(
                        color: Get.theme.colorScheme.onSurfaceVariant
                            .withOpacity(.64),
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
