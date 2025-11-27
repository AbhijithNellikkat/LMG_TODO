import 'package:get/get.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/screens/calendar/calendar_screen.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/screens/home/home_screen.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/screens/navbar/navbar_screen.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/screens/todo_details/todo_details_screen.dart';

import 'routes.dart';

class RouteGenerator {
  static const Duration animationDuration = Duration(milliseconds: 500);

  static final routes = [
    GetPage(name: Routes.initial, page: () => const ScreenOnboarding()),

    GetPage(
      name: Routes.navbar,
      page: () => ScreenNavbar(),
      transition: Transition.fadeIn,
      transitionDuration: animationDuration,
    ),
    GetPage(
      name: Routes.calendar,
      page: () => ScreenCalendar(),
      transition: Transition.fadeIn,
      transitionDuration: animationDuration,
    ),
    GetPage(
      name: Routes.home,
      page: () => ScreenHome(),
      transition: Transition.fadeIn,
      transitionDuration: animationDuration,
    ),
    GetPage(
      name: Routes.todoDetails,
      page: () => ScreenTodoDetails(),
      transition: Transition.fadeIn,
      transitionDuration: animationDuration,
    ),
  ];
}
