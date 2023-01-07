import 'package:dicoding_restaurant_app/models/restaurant.dart';
import 'package:dicoding_restaurant_app/utils/utils.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget {
  static String route = '/restaurant-detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RestaurantDetailPage> {
  late Utils _utils;

  @override
  Widget build(BuildContext context) {
    _utils = Utils(context);

    return Scaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Hero(
                  tag: widget.restaurant.pictureId!,
                  child: Image.network(
                    widget.restaurant.pictureId!,
                  ),
                ),
              ),

              // title
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Text(
                  widget.restaurant.name!,
                  style: TextStyle(
                    fontSize: _utils.textTheme.headline4!.fontSize,
                  ),
                ),
              ),

              // location
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Row(children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: Colors.indigo,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.restaurant.city!,
                    style: TextStyle(
                      fontSize: _utils.textTheme.subtitle1!.fontSize,
                      color: Colors.grey.shade700,
                    ),
                  )
                ]),
              ),

              // description
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 24,
                ),
                child: Text(
                  widget.restaurant.description!,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: _utils.textTheme.bodyText1!.fontSize,
                  ),
                ),
              ),

              // foods
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 24,
                  bottom: 8,
                ),
                child: Text(
                  'Foods',
                  style: TextStyle(
                    fontSize: _utils.textTheme.headline6!.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _listItemMenu(
                    (widget.restaurant.menus!['foods'] as List)[index]['name'],
                    index,
                    index ==
                        ((widget.restaurant.menus!['foods'] as List).length -
                            1),
                  ),
                  itemCount: (widget.restaurant.menus!['foods'] as List).length,
                ),
              ),

              // drinks
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 24,
                  bottom: 8,
                ),
                child: Text(
                  'Drinks',
                  style: TextStyle(
                    fontSize: _utils.textTheme.headline6!.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _listItemMenu(
                    (widget.restaurant.menus!['drinks'] as List)[index]['name'],
                    index,
                    index ==
                        ((widget.restaurant.menus!['drinks'] as List).length -
                            1),
                    isFood: false,
                  ),
                  itemCount:
                      (widget.restaurant.menus!['drinks'] as List).length,
                ),
              ),

              const SizedBox(height: 32),
            ],
          )),
    );
  }

  Widget _listItemMenu(String name, int index, bool isLast,
      {bool isFood = true}) {
    return Card(
      margin: EdgeInsets.only(
        left: index == 0 ? 16 : 8,
        right: isLast ? 16 : 0,
        bottom: 2,
      ),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.64,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  isFood
                      ? 'https://images.unsplash.com/photo-1481070555726-e2fe8357725c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80'
                      : 'https://images.unsplash.com/photo-1609951651556-5334e2706168?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDR8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: _utils.textTheme.bodyText1!.fontSize,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'IDR 15.000',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: _utils.textTheme.caption!.fontSize,
                        ),
                      ),
                    ]),
              )
            ],
          )),
    );
  }
}
