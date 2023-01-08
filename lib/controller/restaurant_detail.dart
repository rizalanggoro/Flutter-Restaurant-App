import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/result/restaurant_detail_result.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:get/get.dart';

class RestaurantDetailController extends GetxController {
  final ApiService _apiService = ApiService();
  late RestaurantDetailResult _restaurantDetailResult;

  Rx<ResultState> resultState = Rx(ResultState.loading);
  String _message = '';

  RestaurantDetailResult get restaurantDetailResult => _restaurantDetailResult;
  String get message => _message;

  void fetchData(String id) async {
    resultState.value = ResultState.loading;

    try {
      _restaurantDetailResult = await _apiService.fetchRestaurantById(id);

      if (_restaurantDetailResult.error) {
        resultState.value = ResultState.error;
        _message = _restaurantDetailResult.message;
      } else {
        resultState.value = ResultState.hasData;
      }
    } catch (err) {
      resultState.value = ResultState.error;
      _message = 'Something went wrong! Please try again later...';
    }
  }
}
