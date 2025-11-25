import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';

class RouteGenerator {
  static const Duration animationDuration = Duration(milliseconds: 500);

  static final routes = [
    GetPage(name: Routes.splash, page: () => const Scaffold()),
    GetPage(
      name: Routes.home,
      page: () => Scaffold(),
      transition: Transition.fadeIn,
      transitionDuration: animationDuration,
    ),
  ];
}
