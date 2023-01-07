import 'package:dicoding_restaurant_app/data/model/restaurant.dart';

class RestaurantDetailResult {
  final bool error;
  final String message;
  final Restaurant restaurant;

  RestaurantDetailResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResult.fromMap(Map<String, dynamic> map) =>
      RestaurantDetailResult(
        error: map['error'],
        message: map['message'],
        restaurant: map['restaurant'],
      );
}
