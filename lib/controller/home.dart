import 'package:get/get.dart';

class HomeController extends GetxController {
  var navigationBarIndex = 0.obs;

  void changeNavigationBarIndex(value) {
    if (navigationBarIndex.value != value) {
      navigationBarIndex.value = value;
    }
  }
}
