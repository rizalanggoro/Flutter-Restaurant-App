import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CardRestaurant extends StatelessWidget {
  final bool isLast;
  final Restaurant restaurant;

  const CardRestaurant({
    Key? key,
    required this.isLast,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: isLast ? 8 : 0,
      ),
      child: Card(
        margin: const EdgeInsets.all(0),
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
                  borderRadius: BorderRadius.all(Radius.circular(16)),
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
                    fontSize: Get.textTheme.subtitle1!.fontSize,
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
                    fontSize: Get.textTheme.bodyMedium!.fontSize,
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
                        fontSize: Get.textTheme.bodyMedium!.fontSize,
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
                        fontSize: Get.textTheme.bodyMedium!.fontSize,
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
