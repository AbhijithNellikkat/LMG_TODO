import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';
import 'package:lmg_todo/application/presentation/utils/dialogs/dialogs.dart';
import 'package:lmg_todo/application/presentation/utils/intl/date_time_fomatter.dart';
import 'package:lmg_todo/application/presentation/widgets/loading_indicator.dart';

import '../../../controller/todo_controller.dart';
import '../../routes/routes.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
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

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Obx(() {
              //     final todoOnlyList = controller.todos
              //         .where((t) => t.status == 'TODO')
              //         .toList();

              //     return Visibility(
              //       visible: todoOnlyList.isNotEmpty,
              //       child: CarouselSlider.builder(
              //         itemCount: todoOnlyList.length,
              //         options: CarouselOptions(
              //           height: 150.h,
              //           autoPlay: true,
              //           autoPlayInterval: const Duration(seconds: 3),
              //           enlargeCenterPage: true,
              //           viewportFraction: 0.75,
              //           enableInfiniteScroll: true,
              //           autoPlayCurve: Curves.fastOutSlowIn,
              //         ),
              //         itemBuilder: (context, index, realIndex) {
              //           final todo = todoOnlyList[index];

              //           String formatTime(int seconds) {
              //             final d = Duration(seconds: seconds);
              //             return d.toString().split('.').first;
              //           }

              //           final passedSeconds =
              //               todo.totalSeconds - todo.remainingSeconds;

              //           return Container(
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               color: kprimary.withOpacity(0.9),
              //               borderRadius: BorderRadius.circular(16),
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black.withOpacity(0.08),
              //                   blurRadius: 10,
              //                   offset: const Offset(0, 4),
              //                 ),
              //               ],
              //             ),
              //             child: Padding(
              //               padding: EdgeInsets.all(26.w),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     todo.title,
              //                     style: const TextStyle(
              //                       fontSize: 20,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.white,
              //                     ),
              //                   ),
              //                   SizedBox(height: 6),
              //                   Text(
              //                     todo.description,
              //                     style: const TextStyle(
              //                       fontSize: 10,
              //                       fontWeight: FontWeight.normal,
              //                       color: Colors.white,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     );
              //   }),
              // ),
              adjustHieght(20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBar(
                  controller: controller.searchCtrl,
                  onChanged: (value) {
                    controller.searchQuery.value = value.trim();
                  },
                  hintText: 'Search....',
                  hintStyle: WidgetStatePropertyAll(
                    Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 14.sp),
                  ),
                  trailing: [Icon(Iconsax.search_normal)],
                ),
              ),
              adjustHieght(10.h),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CustomLoadingIndicator());
                  } else if (controller.todos.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await controller.loadTodos();
                      },
                      child: ListView(
                        children: [
                          SizedBox(height: 120),
                          Center(child: Text('No todos yet. Tap + to add')),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16.w),
                    itemCount: controller.filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = controller.filteredTodos[index];

                      IconData leadingIcon = Iconsax.task;

                      if (todo.status == 'COMPLETED') {
                        leadingIcon = Iconsax.tick_circle;
                      } else if (todo.status == 'TODO') {
                        leadingIcon = Iconsax.timer;
                      } else if (todo.status == 'In-PROGRESS') {
                        leadingIcon = Icons.radar;
                      } else if (todo.status == 'PAUSE') {
                        leadingIcon = Icons.pause;
                      }

                      return FadeInUp(
                        animate: true,
                        from: 10,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              onTap: () {
                                Get.toNamed(
                                  Routes.todoDetails,
                                  arguments: todo,
                                );
                              },
                              leading: CircleAvatar(
                                child: Icon(leadingIcon, color: kwhite),
                              ),
                              title: Text(
                                todo.title,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              subtitle: Text(
                                formatSeconds(todo.remainingSeconds),
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              trailing: Obx(() {
                                bool isDeleting =
                                    controller.deletingTodoId.value ==
                                    todo.todoLocalId;

                                return GestureDetector(
                                  onTap: isDeleting
                                      ? null
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomConfirmationDialog(
                                                  message:
                                                      'Are you sure you want to delete this todo?',
                                                  cancelText: 'Cancel',
                                                  confirmText: 'Delete',
                                                  onCancel: () => Get.back(),
                                                  onConfirm: () {
                                                    controller.deleteTodo(todo);
                                                    Get.back();
                                                  },
                                                ),
                                          );
                                        },
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kprimary.withOpacity(0.8),
                                    child: isDeleting
                                        ? SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: CustomLoadingIndicator(),
                                          )
                                        : Icon(
                                            Iconsax.close_square,
                                            color: Colors.white,
                                          ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
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
