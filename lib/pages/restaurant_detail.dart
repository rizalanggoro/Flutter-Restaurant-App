import 'package:dicoding_restaurant_app/controller/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RestaurantDetailPage extends GetView<RestaurantDetailController> {
  static String route = '/restaurant-detail';

  const RestaurantDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = Get.arguments['id'];

    RestaurantDetailController controller =
        Get.put(RestaurantDetailController());
    controller.fetchData(id);

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: Obx(() {
        var state = controller.resultState.value;
        if (state == ResultState.loading) {
          return _loading;
        } else if (state == ResultState.error) {
          return _errorMessage(controller.message);
        }

        return _buildDetailScreen(controller);
      }),
    );
  }

  Widget _buildDetailScreen(RestaurantDetailController controller) {
    RestaurantDetail restaurantDetail =
        controller.restaurantDetailResult.restaurant;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${restaurantDetail.pictureId}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: Get.size.height / 3,
            ),
          ),

          // restaurant name
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Text(
              restaurantDetail.name,
              style: TextStyle(
                fontSize: Get.textTheme.headline4!.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // restaurant address & city
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 24,
                  color: Get.theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${restaurantDetail.address}, ${restaurantDetail.city}',
                    style: TextStyle(
                      fontSize: Get.textTheme.subtitle1!.fontSize,
                      color:
                          Get.theme.colorScheme.onBackground.withOpacity(.64),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // restaurant rating
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: 8,
            ),
            child: Row(
              children: [
                RatingBar.builder(
                  glow: false,
                  ignoreGestures: true,
                  itemSize: 24,
                  unratedColor:
                      Get.theme.colorScheme.onSurfaceVariant.withOpacity(.24),
                  initialRating: restaurantDetail.rating,
                  itemCount: 5,
                  allowHalfRating: true,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {},
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${restaurantDetail.rating}',
                    style: TextStyle(
                      fontSize: Get.textTheme.subtitle1!.fontSize,
                      color:
                          Get.theme.colorScheme.onBackground.withOpacity(.64),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // categories
          SizedBox(
            height: 48,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 8,
                  ),
                  child: Chip(
                    label: Text(
                      restaurantDetail.categories[index]['name'],
                      style: TextStyle(
                        fontSize: Get.textTheme.bodyText2!.fontSize,
                        color: Get.theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    backgroundColor: Get.theme.colorScheme.secondaryContainer,
                  ),
                );
              },
              itemCount: restaurantDetail.categories.length,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),

          // restaurant description
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Text(
              restaurantDetail.description,
              style: TextStyle(
                fontSize: Get.textTheme.bodyText1!.fontSize,
                color: Get.theme.colorScheme.onBackground.withOpacity(.64),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: Get.theme.colorScheme.errorContainer,
            ),
            padding: const EdgeInsets.all(16),
            child: Icon(
              Icons.info_outline_rounded,
              color: Get.theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Error!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Get.textTheme.headline6!.fontSize,
              color: Get.theme.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Get.textTheme.subtitle1!.fontSize,
              color: Get.theme.colorScheme.onBackground.withOpacity(.64),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _loading {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Loading restaurant details...',
            style: TextStyle(
              color: Get.theme.colorScheme.onBackground.withOpacity(.64),
              fontSize: Get.textTheme.subtitle1!.fontSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItemMenu(
    String name,
    int index,
    bool isLast, {
    bool isFood = true,
  }) {
    return Card(
      margin: EdgeInsets.only(
        left: index == 0 ? 16 : 8,
        right: isLast ? 16 : 0,
        bottom: 2,
      ),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
          width: Get.size.width / 1.64,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  isFood
                      ? 'https://images.unsplash.com/photo-1481070555726-e2fe8357725c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80'
                      : 'https://images.unsplash.com/photo-1609951651556-5334e2706168?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDR8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: Get.textTheme.bodyText1!.fontSize,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'IDR 15.000',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: Get.textTheme.caption!.fontSize,
                        ),
                      ),
                    ]),
              )
            ],
          )),
    );
  }
}
