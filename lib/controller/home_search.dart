import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/result/restaurant_search_result.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeSearchController extends GetxController {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ApiService _apiService = ApiService();

  final Rx<ResultState> resultState = Rx(ResultState.initial);

  late RestaurantSearchResult _restaurantSearchResult;
  String _message = '';

  TextEditingController get textEditingController => _textEditingController;
  FocusNode get focusNode => _focusNode;
  RestaurantSearchResult get restaurantSearchResult => _restaurantSearchResult;
  String get message => _message;

  void clearSearchField() {
    _focusNode.unfocus();
    _textEditingController.text = '';
    resultState.value = ResultState.initial;
  }

  void searchRestaurant() async {
    _focusNode.unfocus();
    var query = _textEditingController.text;

    if (query.isEmpty) {
      resultState.value = ResultState.error;
      _message = 'Query should not empty!';
    } else {
      try {
        resultState.value = ResultState.loading;

        _restaurantSearchResult = await _apiService.searchRestaurant(query);
        if (_restaurantSearchResult.error) {
          resultState.value = ResultState.error;
        } else {
          if (_restaurantSearchResult.founded == 0) {
            resultState.value = ResultState.noData;
          } else {
            resultState.value = ResultState.hasData;
          }
        }
      } catch (err) {
        resultState.value = ResultState.error;
        _message = 'Something went wrong! Please try again later...';
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }
}
