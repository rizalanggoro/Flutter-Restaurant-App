import 'package:dicoding_restaurant_app/controller/restaurant_add_review.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantAddReviewPage extends GetView<RestaurantAddReviewController> {
  static const String route = '/restaurant-add-review';
  const RestaurantAddReviewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RestaurantAddReviewController controller =
        Get.find<RestaurantAddReviewController>();

    String restaurantId = Get.arguments['id'];
    String restaurantName = Get.arguments['name'];

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // safe area
            SafeArea(child: Container()),

            // title
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Text(
                'Add Review',
                style: TextStyle(
                  fontSize: Get.textTheme.headline4!.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.colorScheme.onBackground,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 4,
              ),
              child: Text(
                'Add some reviews for the restaurant $restaurantName',
                style: TextStyle(
                  fontSize: Get.textTheme.subtitle1!.fontSize,
                  color: Get.theme.colorScheme.onBackground.withOpacity(.64),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: ObxValue(
                (enable) => TextField(
                  enabled: enable.value,
                  controller: controller.textEditingControllerName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    label: Text('Name'),
                  ),
                ),
                controller.enableEditing,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: ObxValue(
                (enable) => TextField(
                  enabled: enable.value,
                  controller: controller.textEditingControllerReview,
                  maxLines: null,
                  minLines: 5,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    label: Text('Review'),
                  ),
                ),
                controller.enableEditing,
              ),
            ),

            // error container
            ObxValue(
              (resultState) {
                var state = resultState.value;
                var isError = state == ResultState.error;
                var isHasData = state == ResultState.hasData;

                if (isError || isHasData) {
                  return Container(
                    margin: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                      top: 24,
                    ),
                    width: double.infinity,
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      elevation: 0,
                      color: isError
                          ? Get.theme.colorScheme.errorContainer
                          : Get.theme.colorScheme.secondaryContainer,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              alignment: Alignment.center,
                              width: 48,
                              child: Icon(
                                isError
                                    ? Icons.warning_rounded
                                    : Icons.done_rounded,
                                color: isError
                                    ? Get.theme.colorScheme.error
                                    : Get.theme.colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isError ? 'Error!' : 'Success!',
                                    style: TextStyle(
                                      fontSize:
                                          Get.textTheme.subtitle1!.fontSize,
                                      color: isError
                                          ? Get.theme.colorScheme
                                              .onErrorContainer
                                          : Get.theme.colorScheme
                                              .onSecondaryContainer,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isError
                                        ? controller.message
                                        : 'Your review was published successfully!',
                                    style: TextStyle(
                                      fontSize:
                                          Get.textTheme.bodyMedium!.fontSize,
                                      color: isError
                                          ? Get.theme.colorScheme
                                              .onErrorContainer
                                              .withOpacity(.64)
                                          : Get.theme.colorScheme
                                              .onSecondaryContainer
                                              .withOpacity(.64),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return Container();
              },
              controller.resultState,
            ),

            // loading container
            ObxValue(
              (state) => state.value == ResultState.loading
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Posting your review...',
                            style: TextStyle(
                              color: Get.theme.colorScheme.onBackground
                                  .withOpacity(.64),
                              fontSize: Get.textTheme.bodyMedium!.fontSize,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: Get.textTheme.bodyMedium!.fontSize,
                            height: Get.textTheme.bodyMedium!.fontSize,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              controller.resultState,
            ),

            // button
            ObxValue(
              (state) => (state.value == ResultState.initial ||
                      state.value == ResultState.error)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => controller.publishReview(
                              id: restaurantId,
                            ),
                            child: const Text('Publish'),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              controller.resultState,
            ),
          ],
        ),
      ),
    );
  }
}
