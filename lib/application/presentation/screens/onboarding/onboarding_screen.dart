import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';
import 'package:lmg_todo/application/presentation/widgets/custom_event_button.dart';

class ScreenOnboarding extends StatelessWidget {
  const ScreenOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(onboardingBgImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 80,
              left: 70,
              child: Image.asset(imgStopWatch, width: 50),
            ),

            Positioned(
              top: 150,
              right: 50,
              child: Image.asset(imgDeskCal, width: 60),
            ),

            Positioned(
              top: 190,
              left: 40,
              child: Image.asset(imgPieChart, width: 50),
            ),

            Positioned(
              bottom: 460,
              right: 40,
              child: Image.asset(imgNotifications, width: 95),
            ),

            Positioned(
              bottom: 340,
              left: 30,
              child: Image.asset(imgVase, width: 50),
            ),

            Positioned(
              top: 160,
              left: 0,
              right: 0,
              child: Center(child: Image.asset(imgGirlLaptop, width: 230)),
            ),

            Positioned(
              bottom: 70,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Organize Your Day Easily",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                  ),
                  adjustHieght(10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42),
                    child: Text(
                      "Stay on top of your tasks with a clean and simple to-do manager designed to keep you focused.",
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 13.sp),
                    ),
                  ),
                  adjustHieght(10.h),
                  CustomEventButton(
                    text: "Let's Start",
                    onTap: () {},
                    clr: kprimary,
                    textColr: kwhite,
                    icon: Icons.arrow_right_alt_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
