import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/result/restaurant_list_result.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:get/get.dart';

class HomeListController extends GetxController {
  final ApiService _apiService = ApiService();

  Rx<ResultState> resultState = Rx(ResultState.loading);
  late RestaurantListResult _restaurantListResult;
  String _message = '';

  String get message => _message;
  RestaurantListResult get restaurantListResult => _restaurantListResult;

  @override
  void onInit() {
    super.onInit();

    _fetchData();
  }

  void _fetchData() async {
    try {
      resultState.value = ResultState.loading;
      _restaurantListResult = await _apiService.fetchAllRestaurants();

      if (_restaurantListResult.restaurants.isEmpty) {
        resultState.value = ResultState.noData;
        _message = 'Empty data';
      } else {
        resultState.value = ResultState.hasData;
      }
    } catch (err) {
      resultState.value = ResultState.error;
      _message = 'Error -> $err';
    }
  }
}
