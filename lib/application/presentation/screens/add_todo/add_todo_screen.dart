import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/controller/todo_controller.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';
import 'package:lmg_todo/application/presentation/widgets/custom_event_button.dart';
import 'package:lmg_todo/domain/models/todo/todo_details/todo_details.dart';

class AddEditTodoBottomSheet extends StatefulWidget {
  final TodoDetails? todo; // null = add, not null = edit

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
    final height = MediaQuery.of(context).size.height * 0.8;

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

          const SizedBox(height: 20),

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
                    /// TITLE
                    TextFormField(
                      controller: controller.titleCtrl,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        prefixIcon: Icon(Iconsax.note_text),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter a title" : null,
                    ),
                    const SizedBox(height: 15),

                    /// DESCRIPTION
                    TextFormField(
                      controller: controller.descCtrl,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        prefixIcon: Icon(Iconsax.textalign_left),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// TIMER
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.minCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Minutes",
                              prefixIcon: Icon(Iconsax.timer),
                            ),
                            validator: (value) {
                              int m = int.tryParse(value ?? "0") ?? 0;
                              if (m > 5) return "Max 5 min";
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: controller.secCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Seconds",
                              prefixIcon: Icon(Iconsax.timer_1),
                            ),
                            validator: (value) {
                              int s = int.tryParse(value ?? "0") ?? 0;
                              if (s >= 60) return "Max 59 sec";
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// BUTTONS
                    Row(
                      children: [
                        /// CANCEL
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

                        const SizedBox(width: 15),

                        /// SAVE / UPDATE
                        Expanded(
                          child: CustomEventButton(
                            text: isEdit ? "Update" : "Save",
                            clr: kprimary,
                            textColr: kwhite,
                            shadow: false,
                            onTap: () async {
                              if (isEdit) {
                                /// update existing todo
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
                                /// add new todo
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
