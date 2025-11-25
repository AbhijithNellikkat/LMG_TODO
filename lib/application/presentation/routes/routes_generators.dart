import 'package:get/get.dart';
import 'package:lmg_todo/application/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:lmg_todo/application/presentation/screens/splash/splash_screen.dart';

import 'routes.dart';

class RouteGenerator {
  static const Duration animationDuration = Duration(milliseconds: 500);

  static final routes = [
    GetPage(name: Routes.splash, page: () => const ScreenSplash()),
    GetPage(
      name: Routes.onboarding,
      page: () => ScreenOnboarding(),
      transition: Transition.fadeIn,
      transitionDuration: animationDuration,
    ),
  ];
}
