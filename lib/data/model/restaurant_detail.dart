class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final double rating;
  final List<Map<String, dynamic>> categories;
  final List<List<Map<String, dynamic>>> menus;
  final List<Map<String, dynamic>> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromMap(Map<String, dynamic> map) =>
      RestaurantDetail(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        city: map['city'],
        address: map['address'],
        pictureId: map['pictureId'],
        rating: map['rating'],
        categories: map['categories'],
        menus: map['menus'],
        customerReviews: map['customerReviews'],
      );
}
