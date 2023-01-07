import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/utils/utils.dart';
import 'package:flutter/material.dart';

class RestaurantListPage extends StatefulWidget {
  static String route = '/restaurant-list';
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RestaurantListPage> {
  late Utils _utils;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late List<Restaurant> _listRestaurant;
  late List<Restaurant> _filteredListRestaurant;

  final ValueNotifier<bool> _valueNotifierUseFilter = ValueNotifier(false);

  @override
  void dispose() {
    super.dispose();

    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _utils = Utils(context);

    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _listRestaurant = parseRestaurants(snapshot.data);
            return _body();
          }

          return Container();
        },
        future: DefaultAssetBundle.of(context)
            .loadString('data/local_restaurant.json'),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // safe area
          SafeArea(child: Container()),

          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Text(
              'Restaurant',
              style: TextStyle(
                fontSize: _utils.textTheme.headline4!.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 24,
            ),
            child: Text(
              'Recommendation restaurant for you!',
              style: TextStyle(
                fontSize: _utils.textTheme.subtitle1!.fontSize,
                color: Colors.grey.shade600,
              ),
            ),
          ),

          // search box
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            height: 56,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1.32,
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(28))),
            child: Row(children: [
              const SizedBox(
                  height: 56,
                  width: 56,
                  child: Center(
                      child: Icon(
                    Icons.search_rounded,
                    color: Colors.indigo,
                  ))),
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  onEditingComplete: () {
                    var text = _textEditingController.text;
                    _filteredListRestaurant = _listRestaurant
                        .where((element) => element.name!
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();
                    _valueNotifierUseFilter.value = true;
                  },
                  controller: _textEditingController,
                  style: TextStyle(
                    fontSize: _utils.textTheme.bodyText1!.fontSize,
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search restaurant...',
                  ),
                ),
              ),
              SizedBox(
                height: 56,
                width: 56,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      _textEditingController.text = '';
                      _focusNode.unfocus();
                      _filteredListRestaurant.clear();
                      _valueNotifierUseFilter.value = false;
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ]),
          ),

          // list restaurants
          ValueListenableBuilder(
              valueListenable: _valueNotifierUseFilter,
              builder: (context, bool value, child) {
                List<Restaurant> list =
                    value ? _filteredListRestaurant : _listRestaurant;

                if (list.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) => _listItemRestaurant(
                        list[index], index == (list.length - 1)),
                    itemCount: list.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Text(
                      'Restaurant not found. Try another word',
                      style: TextStyle(
                        fontSize: _utils.textTheme.subtitle1!.fontSize,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Widget _listItemRestaurant(Restaurant restaurant, bool isLast) {
    return Container(
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: isLast ? 32 : 0,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RestaurantDetailPage(restaurant: restaurant),
                ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Hero(
                  tag: restaurant.pictureId!,
                  child: Image.network(
                    restaurant.pictureId!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Text(
                  restaurant.name!,
                  style: TextStyle(
                    fontSize: _utils.textTheme.headline6!.fontSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Text(
                  restaurant.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: _utils.textTheme.subtitle1!.fontSize,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // location
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Colors.indigo,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      restaurant.city!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),

              // rating
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${restaurant.rating!}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
