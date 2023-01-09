import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardRestaurantMenuItem extends StatelessWidget {
  final String title;
  final bool isFirst;
  final bool isLast;
  final bool isFood;

  const CardRestaurantMenuItem({
    Key? key,
    required this.title,
    required this.isFirst,
    required this.isLast,
    required this.isFood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
