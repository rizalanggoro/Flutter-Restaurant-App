import 'package:dicoding_restaurant_app/controller/home.dart';
import 'package:dicoding_restaurant_app/controller/home_list.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => HomeListController(), fenix: true);
  }
}
