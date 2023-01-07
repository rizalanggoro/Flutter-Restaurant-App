import 'package:dicoding_restaurant_app/data/model/restaurant.dart';

class RestaurantListResult {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantListResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResult.fromMap(Map<String, dynamic> map) =>
      RestaurantListResult(
        error: map['error'],
        message: map['message'],
        count: map['count'],
        restaurants: List<Map<String, dynamic>>.from(map['restaurants'])
            .map((e) => Restaurant.fromMap(e))
            .toList(),
      );
}
