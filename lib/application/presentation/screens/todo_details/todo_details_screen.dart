import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/controller/todo_details_controller.dart';
import 'package:lmg_todo/application/presentation/screens/add_or_edit/add_edit_screen.dart';
import 'package:lmg_todo/application/presentation/screens/todo_details/widgets/timer_btn_card.dart';
import 'package:lmg_todo/application/presentation/screens/todo_details/widgets/todo_detail_card.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: _circleIcon(
                        Icons.arrow_back_ios,
                        Colors.grey.shade300,
                        context,
                      ),
                    ),

                    Obx(
                      () => controller.todo.value.status == 'COMPLETED'
                          ? SizedBox.shrink()
                          : GestureDetector(
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
                    ),
                  ],
                ),

                adjustHieght(30.h),

                TodoDetailCard(),
                adjustHieght(20.h),
                TimerBtnCard(),
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
}
