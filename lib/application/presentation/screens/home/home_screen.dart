import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';
import 'package:lmg_todo/application/presentation/utils/dialogs/dialogs.dart';
import 'package:lmg_todo/application/presentation/utils/intl/date_time_fomatter.dart';

import '../../routes/routes.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(screenBgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              adjustHieght(30.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedTextKit(
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            DateTimeFormater.getGreeting(),
                            textStyle: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19.sp,
                                ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                      ),
                      Text(
                        'Have a nice day!',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: kgrey),
                      ),
                    ],
                  ),
                ),
              ),
              adjustHieght(20.h),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarouselSlider.builder(
                  itemCount: 2,
                  options: CarouselOptions(
                    height: 130.h,

                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: true,
                    viewportFraction: 0.75,
                    enableInfiniteScroll: true,

                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kprimary.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              " Your today’s task\n almost done!",
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(color: kwhite),
                            ),
                            Text(
                              '$index',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: kwhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              adjustHieght(20.h),
              SearchBar(),
              adjustHieght(20.h),

              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16.w),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(Routes.todoDetails);
                          },
                          leading: CircleAvatar(
                            backgroundColor: kprimary.withOpacity(0.7),
                            child: Icon(Icons.roundabout_left),
                          ),
                          title: Text(
                            'Task @ $index',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          subtitle: Text(
                            'Grocery shopping app design',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => CustomConfirmationDialog(
                                  message:
                                      'Are you sure you want to delete this todo?',
                                  cancelText: 'Cancel',
                                  confirmText: 'Delete',
                                  onCancel: () => Get.back(),
                                  onConfirm: () {
                                    Get.back();
                                  },
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: kprimary.withOpacity(0.8),
                              child: Icon(Iconsax.close_square),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
