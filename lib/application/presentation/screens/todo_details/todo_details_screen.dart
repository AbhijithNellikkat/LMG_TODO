import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/controller/todo_details_controller.dart';
import 'package:lmg_todo/application/presentation/screens/add_todo/add_todo_screen.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';

class ScreenTodoDetails extends StatelessWidget {
  const ScreenTodoDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoDetailsController>();

    return Scaffold(
      backgroundColor: kwhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(screenBgImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: _circleIcon(
                        Icons.arrow_back_ios,
                        Colors.grey.shade300,
                        context,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Todo Details",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          showDragHandle: true,
                          isDismissible: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          builder: (context) => AddEditTodoBottomSheet(
                            todo: controller.todo.value,
                          ),
                        );
                      },
                      child: _circleIcon(
                        Iconsax.edit,
                        Colors.grey.shade300,
                        context,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                // Card with gradient header
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [kprimary, kwhite],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kprimary.withOpacity(0.6),
                        offset: const Offset(0, 5),
                        blurRadius: 20,
                      ),

                      BoxShadow(
                        color: kblack.withOpacity(0.15),
                        offset: const Offset(-5, -5),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gradient header with title
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Obx(
                          () => Text(
                            controller.todo.value.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Status
                            // Replace your Status Row with this:
                            Obx(() {
                              final status = controller.todo.value.status;

                              Color statusColor;
                              if (status == 'COMPLETED') {
                                statusColor = kgreen;
                              } else if (status == 'TODO') {
                                statusColor = kwhite;
                              } else if (status == 'In-PROGRESS') {
                                statusColor = kblue;
                              } else if (status == 'PAUSE') {
                                statusColor = kred;
                              } else {
                                statusColor = kwhite;
                              }

                              IconData leadingIcon;
                              if (status == 'COMPLETED') {
                                leadingIcon = Iconsax.tick_circle;
                              } else if (status == 'TODO') {
                                leadingIcon = Iconsax.timer;
                              } else if (status == 'In-PROGRESS') {
                                leadingIcon = Icons.radar;
                              } else if (status == 'PAUSE') {
                                leadingIcon = Icons.pause;
                              } else {
                                leadingIcon = Iconsax.task;
                              }

                              return Card(
                                elevation: 0,
                                color: knill,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Status : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontSize: 15.sp,
                                              color: kwhite,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            leadingIcon,
                                            size: 18.sp,
                                            color: statusColor,
                                          ),
                                          SizedBox(width: 6.w),
                                          Text(
                                            status,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 15.sp,
                                                  color: statusColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),

                            SizedBox(height: 20.h),

                            // Description
                            Obx(
                              () => Text(
                                controller.todo.value.description,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      fontSize: 15.sp,
                                      color: kwhite,
                                      letterSpacing: 1.5,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                adjustHieght(20.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Timer
                            Center(
                              child: Obx(
                                () => Text(
                                  controller.todo.value.status == 'COMPLETED'
                                      ? controller.formatTime(
                                          controller.todo.value.totalSeconds,
                                        )
                                      : controller.formatTime(
                                          controller
                                              .todo
                                              .value
                                              .remainingSeconds,
                                        ),
                                  style: TextStyle(
                                    fontSize: 52.sp,
                                    fontWeight: FontWeight.bold,
                                    color: kprimary.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 30.h),

                            // Control Buttons
                            Obx(
                              () => controller.todo.value.status == 'COMPLETED'
                                  ? SizedBox.shrink()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _controlButton(
                                          Iconsax.stop_circle,
                                          Colors.red,
                                          controller.stopTimer,
                                        ),
                                        _controlButton(
                                          Iconsax.pause_circle,
                                          Colors.orange,
                                          controller.pauseTimer,
                                        ),
                                        _controlButton(
                                          Iconsax.play_circle,
                                          Colors.green,
                                          controller.startTimer,
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon, Color bgColor, BuildContext context) {
    return Container(
      width: 45.w,
      height: 45.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: klightgrey),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Center(
        child: Icon(icon, size: 20.sp, color: Colors.black87),
      ),
    );
  }

  Widget _controlButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70.w,
        height: 70.w,
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(icon, size: 36.sp, color: Colors.white),
        ),
      ),
    );
  }
}
