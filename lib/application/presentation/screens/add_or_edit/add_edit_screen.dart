import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/controller/todo_controller.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';
import 'package:lmg_todo/application/presentation/widgets/custom_event_button.dart';
import 'package:lmg_todo/application/presentation/widgets/custom_text_from_field.dart';
import 'package:lmg_todo/domain/models/todo/todo_details/todo_details.dart';

class AddEditTodoBottomSheet extends StatefulWidget {
  final TodoDetails? todo;

  const AddEditTodoBottomSheet({super.key, this.todo});

  @override
  State<AddEditTodoBottomSheet> createState() => _AddEditTodoBottomSheetState();
}

class _AddEditTodoBottomSheetState extends State<AddEditTodoBottomSheet> {
  late bool isEdit;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<TodoController>();
    isEdit = widget.todo != null;

    if (isEdit) {
      controller.titleCtrl.text = widget.todo!.title;
      controller.descCtrl.text = widget.todo!.description;

      int m = widget.todo!.totalSeconds ~/ 60;
      int s = widget.todo!.totalSeconds % 60;

      controller.minCtrl.text = m.toString();
      controller.secCtrl.text = s.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    final height = MediaQuery.of(context).size.height * 0.7;

    return Container(
      height: height,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEdit ? "Edit Todo" : "Add New Todo",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),

          adjustHieght(20.h),

          Text(
            isEdit
                ? "Update your todo title, description and timer."
                : "Create a new task by adding a title, short description, and a timer.\nLet's stay productive!",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black54,
              height: 1.4,
            ),
          ),

          adjustHieght(20.h),

          Form(
            key: controller.formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: 'Enter Todo Title',
                      labelText: 'title',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.titleCtrl,
                      prefixIcon: Icon(Iconsax.note_text),
                      validate: Validate.notNull,
                    ),
                    adjustHieght(15.h),
                    CustomTextFormField(
                      hintText: 'Enter Todo Description',
                      labelText: 'description',
                      controller: controller.descCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validate: Validate.notNull,
                      maxLines: 4,
                    ),

                    adjustHieght(20.h),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: controller.minCtrl,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputType: TextInputType.number,
                            labelText: 'Minutes',
                            hintText: 'Minutes',
                            validate: Validate.maxMinutes,
                            prefixIcon: Icon(Iconsax.timer_1),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CustomTextFormField(
                            controller: controller.secCtrl,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputType: TextInputType.number,
                            labelText: 'Seconds',
                            hintText: 'Seconds',
                            validate: Validate.maxSeconds,
                            prefixIcon: Icon(Iconsax.timer_1),
                          ),
                        ),
                      ],
                    ),

                    adjustHieght(30.h),

                    Row(
                      children: [
                        Expanded(
                          child: CustomEventButton(
                            text: 'Cancel',
                            outlineBorder: true,
                            outlineBorderClr: kprimary,
                            textColr: kprimary,
                            shadow: false,
                            onTap: () {
                              controller.clearAllTextEditingController();
                              Get.back();
                            },
                          ),
                        ),

                        adjustWidth(15.h),

                        Expanded(
                          child: CustomEventButton(
                            text: isEdit ? "Update" : "Save",
                            clr: kprimary,
                            textColr: kwhite,
                            shadow: false,
                            onTap: () async {
                              if (isEdit) {
                                TodoDetails updated = widget.todo!.copyWith(
                                  title: controller.titleCtrl.text.trim(),
                                  description: controller.descCtrl.text.trim(),
                                  totalSeconds: _getTotalSeconds(),
                                  remainingSeconds: _getTotalSeconds(),
                                );

                                await controller.updateTodo(updated);
                                Get.back();
                                controller.clearAllTextEditingController();
                              } else {
                                await controller.addTodo();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getTotalSeconds() {
    final c = Get.find<TodoController>();
    int minutes = int.tryParse(c.minCtrl.text) ?? 0;
    int seconds = int.tryParse(c.secCtrl.text) ?? 0;
    return (minutes * 60) + seconds;
  }
}
