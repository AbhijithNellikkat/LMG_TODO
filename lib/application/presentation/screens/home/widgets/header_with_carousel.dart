import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lmg_todo/application/controller/todo_controller.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';
import 'package:lmg_todo/application/presentation/utils/intl/date_time_fomatter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HeaderWithCarousel extends StatelessWidget {
  const HeaderWithCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          child: Obx(() {
            final todoOnlyList = controller.todos
                .where((t) => t.status == 'TODO')
                .toList();

            return Visibility(
              visible: todoOnlyList.length > 1,
              child: CarouselSlider.builder(
                itemCount: todoOnlyList.length,
                options: CarouselOptions(
                  height: 100.h,
                  autoPlay: true,

                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  viewportFraction: 0.75,
                  enableInfiniteScroll: false,

                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                itemBuilder: (context, index, realIndex) {
                  final todo = todoOnlyList[index];

                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [kprimary, kprimary.withOpacity(0.2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            todo.title,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: kwhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23.sp,
                                ),
                          ),

                          adjustHieght(1.h),
                          Text(
                            todo.description,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: kwhite, fontSize: 13.sp),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,

                            child: Text(
                              formatSeconds(todo.totalSeconds),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: kwhite, fontSize: 15.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  String formatSeconds(int sec) {
    final minutes = (sec ~/ 60).toString().padLeft(1, '0');
    final seconds = (sec % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  String formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}";
  }
}
