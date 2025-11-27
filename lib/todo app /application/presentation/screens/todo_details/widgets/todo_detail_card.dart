import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/todo%20app%20/application/controller/todo_details_controller.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/colors.dart';

class TodoDetailCard extends StatelessWidget {
  const TodoDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoDetailsController>();
    return Container(
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Status : ",
                            style: Theme.of(context).textTheme.bodySmall
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
                                style: Theme.of(context).textTheme.bodySmall
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

                Obx(
                  () => Text(
                    controller.todo.value.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
    );
  }
}
