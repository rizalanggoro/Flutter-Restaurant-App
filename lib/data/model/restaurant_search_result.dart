import 'package:dicoding_restaurant_app/data/model/restaurant.dart';

class RestaurantSearchResult {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  RestaurantSearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResult.fromMap(Map<String, dynamic> map) =>
      RestaurantSearchResult(
        error: map['error'],
        founded: map['founded'],
        restaurants: map['restaurants'],
      );
}
