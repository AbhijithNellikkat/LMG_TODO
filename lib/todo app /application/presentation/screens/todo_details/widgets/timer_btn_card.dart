import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/colors.dart';

import '../../../../controller/todo_details_controller.dart';

class TimerBtnCard extends StatelessWidget {
  const TimerBtnCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoDetailsController>();
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Obx(
                    () => Text(
                      controller.todo.value.status == 'COMPLETED'
                          ? controller.formatTime(
                              controller.todo.value.totalSeconds,
                            )
                          : controller.formatTime(
                              controller.todo.value.remainingSeconds,
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

                Obx(
                  () => controller.todo.value.status == 'COMPLETED'
                      ? SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
