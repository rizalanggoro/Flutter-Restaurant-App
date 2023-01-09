import 'package:dicoding_restaurant_app/controller/home.dart';
import 'package:dicoding_restaurant_app/controller/home_list.dart';
import 'package:dicoding_restaurant_app/controller/home_search.dart';
import 'package:dicoding_restaurant_app/controller/restaurant_add_review.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => HomeSearchController(), fenix: true);
    Get.lazyPut(() => HomeListController(), fenix: true);
    Get.lazyPut(() => RestaurantAddReviewController(), fenix: true);
  }
}
