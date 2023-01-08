class RestaurantSearchResult {
  final bool error;
  final int founded;
  final List<dynamic> restaurants;

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
