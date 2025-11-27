import 'package:animate_do/animate_do.dart';
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
import 'package:lmg_todo/application/presentation/utils/refresh_indicator/refresh_indicator.dart';
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
                            color: kprimary.withOpacity(0.8),
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
                                  formatSeconds(todo.totalSeconds),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: kwhite,

                                        fontSize: 13.sp,
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
              adjustHieght(20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FlipInX(
                  animate: true,
                  child: SearchBar(
                    elevation: WidgetStatePropertyAll(0.9),

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
                    trailing: [Icon(Iconsax.search_normal_14)],
                  ),
                ),
              ),
              adjustHieght(10.h),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CustomLoadingIndicator());
                  } else if (controller.todos.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ErrorRefreshIndicator(
                        onRefresh: () async {
                          await controller.loadTodos();
                        },
                        showTryAgain: false,
                        image: emptyDataImage,
                        errorMessage:
                            'No todos found.\nTap + to add your first todo!',
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

                      Color color = kwhite;

                      if (todo.status == 'COMPLETED') {
                        leadingIcon = Iconsax.tick_circle;
                      } else if (todo.status == 'TODO') {
                        leadingIcon = Iconsax.timer;
                      } else if (todo.status == 'In-PROGRESS') {
                        leadingIcon = Icons.radar;
                      } else if (todo.status == 'PAUSE') {
                        leadingIcon = Icons.pause;
                      }

                      if (todo.status == 'COMPLETED') {
                        color = kgreen;
                      } else if (todo.status == 'TODO') {
                        color = kprimary;
                      } else if (todo.status == 'In-PROGRESS') {
                        color = kblue;
                      } else if (todo.status == 'PAUSE') {
                        color = kred;
                      }
                      return FadeInUp(
                        animate: true,
                        from: 10,
                        child: Card(
                          elevation: 2,
                          shadowColor: color,
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
                                backgroundColor: kprimary.withOpacity(0.8),

                                child: Icon(leadingIcon, color: kwhite),
                              ),
                              title: Text(
                                todo.title,

                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      decoration: todo.status == 'COMPLETED'
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                              ),
                              subtitle: Text(
                                formatSeconds(todo.remainingSeconds),
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      decoration: todo.status == 'COMPLETED'
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
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
                                            Icons.close,
                                            size: 15,
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
