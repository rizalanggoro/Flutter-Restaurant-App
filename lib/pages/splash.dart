import 'dart:ui';

import 'package:dicoding_restaurant_app/pages/home.dart';
import 'package:dicoding_restaurant_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

class SplashPage extends StatelessWidget {
  static String route = '/splash';
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    Utils utils = Utils(context);

    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1578474846511-04ba529f0b88?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    top: 32,
                  ),
                  child: Icon(Icons.restaurant_rounded,
                      color: Colors.white.withOpacity(.64)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 16,
                  ),
                  child: Text(
                    'Less Talk,\nEat More',
                    style: TextStyle(
                      color: const Color(0xffd2a89b),
                      fontSize: utils.textTheme.headline3!.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(32),
                  margin: const EdgeInsets.all(16),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: const Color(0xff3a2419).withOpacity(.56),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8,
                      sigmaY: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find your favorite restaurant here',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: utils.textTheme.headline5!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The best restaurant app in the world in 2023.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.64),
                            fontSize: utils.textTheme.subtitle1!.fontSize,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                HomePage.route,
                              );
                            },
                            child: const Text('Get started'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
