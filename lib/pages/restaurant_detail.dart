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
    // controller.fetchData(id);

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

    List<dynamic> listFoods = restaurantDetail.menus['foods'];
    List<dynamic> listDrinks = restaurantDetail.menus['drinks'];
    List<dynamic> listCustomerReviews = restaurantDetail.customerReviews;
    listCustomerReviews.sort((a, b) => b['date'].compareTo(a['date']));

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
              bottom: 16,
            ),
            child: Text(
              restaurantDetail.description,
              style: TextStyle(
                fontSize: Get.textTheme.bodyText1!.fontSize,
                color: Get.theme.colorScheme.onBackground.withOpacity(.64),
              ),
            ),
          ),

          const Divider(),

          // foods
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
              bottom: 8,
            ),
            child: Text(
              'Foods',
              style: TextStyle(
                fontSize: Get.textTheme.headline6!.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: Get.size.height / 4,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _listItemMenu(
                  title: restaurantDetail.name,
                  isFirst: index == 0,
                  isLast: index == (listFoods.length - 1),
                  isFood: true,
                );
              },
              itemCount: listFoods.length,
            ),
          ),

          // drinks
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
              bottom: 8,
            ),
            child: Text(
              'Drinks',
              style: TextStyle(
                fontSize: Get.textTheme.headline6!.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: Get.size.height / 4,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _listItemMenu(
                  title: restaurantDetail.name,
                  isFirst: index == 0,
                  isLast: index == (listDrinks.length - 1),
                  isFood: false,
                );
              },
              itemCount: listDrinks.length,
            ),
          ),

          const SizedBox(height: 16),
          const Divider(),

          // customer review
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
              bottom: 8,
            ),
            child: Text(
              'Customer Reviews',
              style: TextStyle(
                fontSize: Get.textTheme.headline6!.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            itemBuilder: (context, index) => _listItemReview(
              listCustomerReviews[index],
              index: index,
              len: listCustomerReviews.length,
            ),
            itemCount: listCustomerReviews.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
          ),
        ],
      ),
    );
  }

  Widget _listItemReview(
    Map<String, dynamic> map, {
    required int index,
    required int len,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: index == (len - 1) ? 24 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name and date
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // icon
              Container(
                margin: const EdgeInsets.only(right: 16),
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: 16,
                  color: Get.theme.colorScheme.secondary,
                ),
              ),

              // name
              Expanded(
                  child: Text(
                map['name'] ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Get.theme.colorScheme.onBackground,
                  fontSize: Get.textTheme.subtitle1!.fontSize,
                ),
              )),
              const SizedBox(width: 16),

              // date
              Text(
                map['date'] ?? '-',
                style: TextStyle(
                  color: Get.theme.colorScheme.onBackground.withOpacity(.64),
                  fontSize: Get.textTheme.bodySmall!.fontSize,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // review
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              map['review'] ?? '-',
              style: TextStyle(
                color: Get.theme.colorScheme.onBackground.withOpacity(.64),
                fontSize: Get.textTheme.bodyMedium!.fontSize,
              ),
            ),
          ),

          // divider
          if (index != (len - 1))
            const Padding(
              padding: EdgeInsets.only(
                left: 40,
                top: 8,
              ),
              child: Divider(),
            ),
        ],
      ),
    );
  }

  Widget _listItemMenu({
    required String title,
    required bool isFirst,
    required bool isLast,
    required bool isFood,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: isFirst ? 16 : 8,
        right: isLast ? 16 : 0,
      ),
      width: Get.size.width / 1.64,
      height: Get.size.height / 4,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Get.theme.colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Image.network(
                  'https://source.unsplash.com/random/?${isFood ? 'food' : 'drink'}',
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
                title,
                style: TextStyle(
                  fontSize: Get.textTheme.subtitle1!.fontSize,
                  color: Get.theme.colorScheme.onBackground,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Text(
                'IDR 15.000',
                style: TextStyle(
                  fontSize: Get.textTheme.bodyMedium!.fontSize,
                  color: Get.theme.colorScheme.onBackground.withOpacity(.64),
                ),
              ),
            ),
          ],
        ),
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
}
