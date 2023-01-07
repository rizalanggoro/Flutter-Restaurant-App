import 'dart:convert';

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;
  Map<String, dynamic>? menus;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  factory Restaurant.fromJsom(Map<String, dynamic> map) => Restaurant(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        pictureId: map['pictureId'],
        city: map['city'],
        rating: map['rating'] is int ? map['rating'] + 0.0 : map['rating'],
        menus: Map<String, dynamic>.from(map['menus']),
      );
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  } else {
    var map = jsonDecode(json);

    List parsedList = map['restaurants'];
    List<Restaurant> list =
        parsedList.map((item) => Restaurant.fromJsom(item)).toList();

    return list;
  }
}
