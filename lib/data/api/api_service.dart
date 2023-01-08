import 'dart:convert';

import 'package:dicoding_restaurant_app/data/model/result/restaurant_detail_result.dart';
import 'package:dicoding_restaurant_app/data/model/result/restaurant_list_result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantListResult> fetchAllRestaurants() async {
    final response = await http.get(Uri.parse('${_baseUrl}list'));
    if (response.statusCode == 200) {
      return RestaurantListResult.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch list restaurants');
    }
  }

  Future<RestaurantDetailResult> fetchRestaurantById(String id) async {
    final response = await http.get(Uri.parse('${_baseUrl}detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to retrieve restaurant details');
    }
  }
}
