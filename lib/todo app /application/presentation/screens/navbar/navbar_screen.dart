import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/controller/navbar_controller.dart';
import 'package:lmg_todo/application/presentation/screens/add_or_edit/add_edit_screen.dart';
import 'package:lmg_todo/application/presentation/screens/calendar/calendar_screen.dart';
import 'package:lmg_todo/application/presentation/screens/home/home_screen.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';
import 'package:lmg_todo/application/presentation/utils/tost/flutter_tost.dart';

// ignore: must_be_immutable
class ScreenNavbar extends StatelessWidget {
  ScreenNavbar({super.key});

  final pages = const [ScreenHome(), ScreenCalendar()];
  DateTime? lastBackPressed;
  @override
  Widget build(BuildContext context) {
    final navbarController = Get.find<NavbarController>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        final currentIndex = navbarController.currentIndex.value;

        if (currentIndex != 0) {
          navbarController.changeTab(0);
        } else {
          final now = DateTime.now();
          if (lastBackPressed == null ||
              now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
            lastBackPressed = now;
            showCustomToast(message: 'Press back again to exit');
          } else {
            // Exit app
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        extendBody: true,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(screenBgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Obx(() => pages[navbarController.currentIndex.value]),
        ),
        floatingActionButton: Pulse(
          animate: true,

          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                isDismissible: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                builder: (context) => AddEditTodoBottomSheet(),
              );
            },
            backgroundColor: kprimary.withOpacity(0.7),
            child: Icon(Iconsax.add, color: kwhite),
          ),
        ),
        bottomNavigationBar: Obx(
          () => CircleNavBar(
            height: 60,
            activeIndex: navbarController.currentIndex.value,
            elevation: 20,
            circleGradient: LinearGradient(
              colors: [
                const Color(0xFF5F33E1).withOpacity(0.6),
                const Color(0xFF5F33E1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            circleWidth: 50,
            activeIcons: [
              Icon(Iconsax.task, color: Colors.white),

              Icon(Iconsax.calendar5, color: Colors.white),
            ],
            inactiveIcons: [
              Icon(Iconsax.task_square, color: Colors.black54),

              Icon(Iconsax.calendar_1, color: Colors.black54),
            ],
            color: Colors.white,
            circleColor: const Color(0xFF5F33E1),
            shadowColor: Color(0xFF5F33E1).withOpacity(0.2),
            circleShadowColor: Colors.black26,
            onTap: (index) {
              navbarController.changeTab(index);
            },

            cornerRadius: BorderRadius.circular(21),
          ),
        ),
      ),
    );
  }
}
