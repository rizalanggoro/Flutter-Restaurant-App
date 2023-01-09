import 'dart:convert';

import 'package:dicoding_restaurant_app/controller/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/data/states/result_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RestaurantAddReviewController extends GetxController {
  Rx<ResultState> resultState = Rx(ResultState.initial);
  Rx<bool> enableEditing = Rx(true);

  final TextEditingController _textEditingControllerName =
      TextEditingController();
  final TextEditingController _textEditingControllerReview =
      TextEditingController();
  String _message = '';

  TextEditingController get textEditingControllerName =>
      _textEditingControllerName;
  TextEditingController get textEditingControllerReview =>
      _textEditingControllerReview;
  String get message => _message;

  void publishReview({
    required String id,
  }) async {
    try {
      var name = _textEditingControllerName.text;
      var review = _textEditingControllerReview.text;

      if (name.isNotEmpty && review.isNotEmpty) {
        resultState.value = ResultState.loading;
        enableEditing.value = false;

        var response = await http.post(
          Uri.parse('https://restaurant-api.dicoding.dev/review'),
          body: {
            'id': id,
            'name': name,
            'review': review,
          },
        );

        if (response.statusCode == 201) {
          var body = jsonDecode(response.body);

          if (body['error'] as bool) {
            resultState.value = ResultState.error;
            enableEditing.value = true;
            _message = 'Something went wrong! Please try again later...';
          } else {
            resultState.value = ResultState.hasData;
            enableEditing.value = true;
            _textEditingControllerName.text = '';
            _textEditingControllerReview.text = '';

            Get.find<RestaurantDetailController>().fetchData(id);

            Future.delayed(
              const Duration(seconds: 2),
              () => resultState.value = ResultState.initial,
            );
          }
        } else {
          resultState.value = ResultState.error;
          enableEditing.value = true;
          _message = 'Something went wrong! Please try again later...';
        }
      }
    } catch (error) {
      resultState.value = ResultState.error;
      enableEditing.value = true;
      _message = 'Something went wrong! Please try again later...';
    }
  }

  @override
  void dispose() {
    super.dispose();

    _textEditingControllerName.dispose();
    _textEditingControllerReview.dispose();
  }
}
