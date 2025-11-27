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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: _circleIcon(context, Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Todo Details",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 15.sp,
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
                        builder: (context) =>
                            AddEditTodoBottomSheet(todo: controller.todo.value),
                      );
                    },
                    child: _circleIcon(context, Iconsax.edit),
                  ),
                ],
              ),

              adjustHieght(20.h),

              // Title - Reactive
              Obx(
                () => Text(
                  controller.todo.value.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: kprimary,
                  ),
                ),
              ),

              adjustHieght(10.h),

              // Status - Reactive
              Obx(
                () => Row(
                  children: [
                    const Text(
                      "Status: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Chip(
                      label: Text(controller.todo.value.status),
                      backgroundColor: _getStatusColor(
                        controller.todo.value.status,
                      ),
                    ),
                  ],
                ),
              ),

              adjustHieght(20.h),

              // Description - Reactive
              Obx(
                () => Text(
                  controller.todo.value.description,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
              ),

              adjustHieght(30.h),

              // Timer Display - Reactive
              Center(
                child: Obx(
                  () => Text(
                    controller.formatTime(
                      controller.todo.value.remainingSeconds,
                    ),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              adjustHieght(30.h),

              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.stop_circle, size: 40),
                    color: Colors.red,
                    onPressed: controller.stopTimer,
                  ),
                  const SizedBox(width: 20),

                  IconButton(
                    icon: const Icon(Iconsax.pause_circle, size: 40),
                    color: Colors.orange,
                    onPressed: controller.pauseTimer,
                  ),

                  const SizedBox(width: 20),

                  IconButton(
                    icon: const Icon(Iconsax.play_circle, size: 40),
                    color: Colors.green,
                    onPressed: controller.startTimer,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleIcon(BuildContext context, IconData icon) {
    return Container(
      width: 45.w,
      height: 45.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: klightgrey),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: icon == Icons.arrow_back_ios ? 5.w : 0,
          ),
          child: Icon(icon, size: 18.sp),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green.shade200;
      case "In-Progress":
        return Colors.blue.shade200;
      case "TODO":
      default:
        return Colors.orange.shade200;
    }
  }
}
