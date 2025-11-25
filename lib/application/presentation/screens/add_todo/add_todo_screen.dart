import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';
import 'package:lmg_todo/application/presentation/widgets/custom_event_button.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({super.key});

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController minCtrl = TextEditingController(text: "0");
  final TextEditingController secCtrl = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    // final todoController = Get.find<TodoController>();
    final height = MediaQuery.of(context).size.height * 0.8;

    return Container(
      height: height,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ===== TITLE =====
          Text(
            "Add New Todo",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            "Create a new task by adding a title, short description, and a timer.\nLet's stay productive! ",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black54,
              height: 1.4,
            ),
          ),

          adjustHieght(20.h),

          /// ===== FORM =====
          Form(
            key: _formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// TITLE FIELD
                    TextFormField(
                      controller: titleCtrl,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        prefixIcon: Icon(Iconsax.note_text),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter a title" : null,
                    ),
                    const SizedBox(height: 15),

                    /// DESCRIPTION FIELD
                    TextFormField(
                      controller: descCtrl,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        prefixIcon: Icon(Iconsax.textalign_left),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// TIMER FIELD
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: minCtrl,
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
                            controller: secCtrl,
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

                    /// ===== BUTTONS =====
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
                              Get.back();
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CustomEventButton(
                            shadow: false,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) return;

                              int minutes = int.tryParse(minCtrl.text) ?? 0;
                              int seconds = int.tryParse(secCtrl.text) ?? 0;

                              int totalSeconds = (minutes * 60) + seconds;

                              /// EMPTY TIMER CHECK
                              if (totalSeconds == 0) {
                                Get.snackbar("Error", "Timer cannot be 0 sec");
                                return;
                              }

                              /// MAX TIME CHECK (300 sec = 5 min)
                              if (totalSeconds > 300) {
                                Get.snackbar(
                                  "Error",
                                  "Maximum time is 5 minutes",
                                );
                                return;
                              }

                              /// MORE STRICT VALIDATION:
                              if (minutes == 5 && seconds > 0) {
                                Get.snackbar(
                                  "Error",
                                  "Max allowed is exactly 5:00 minutes",
                                );
                                return;
                              }

                              Navigator.pop(context);
                            },

                            text: "Save",
                            clr: kprimary,
                            textColr: kwhite,
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
}
