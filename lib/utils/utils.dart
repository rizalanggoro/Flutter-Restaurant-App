import 'package:flutter/material.dart';

class Utils {
  BuildContext context;

  Utils(this.context);

  TextTheme get textTheme => Theme.of(context).textTheme;
}
