import 'dart:convert';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) => Restaurant(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        pictureId: map['pictureId'],
        city: map['city'],
        rating: map['rating'] is int ? map['rating'] + 0.0 : map['rating'],
      );
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  } else {
    var map = jsonDecode(json);

    List parsedList = map['restaurants'];
    List<Restaurant> list =
        parsedList.map((item) => Restaurant.fromMap(item)).toList();

    return list;
  }
}
