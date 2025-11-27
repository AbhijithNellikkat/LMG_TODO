import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/routes/routes.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/colors.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/constants.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/dialogs/dialogs.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/refresh_indicator/refresh_indicator.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/widgets/loading_indicator.dart';

import '../../../../controller/todo_controller.dart';

class TodosList extends StatelessWidget {
  const TodosList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    return Expanded(
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
              errorMessage: 'No todos found.\nTap + to add your first todo!',
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
                      Get.toNamed(Routes.todoDetails, arguments: todo);
                    },
                    leading: CircleAvatar(
                      backgroundColor: kprimary.withOpacity(0.8),

                      child: Icon(leadingIcon, color: kwhite),
                    ),
                    title: Text(
                      todo.title,

                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        decoration: todo.status == 'COMPLETED'
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      formatSeconds(todo.remainingSeconds),
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: todo.status == 'COMPLETED'
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Obx(() {
                      bool isDeleting =
                          controller.deletingTodoId.value == todo.todoLocalId;

                      return GestureDetector(
                        onTap: isDeleting
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomConfirmationDialog(
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
    );
  }

  String formatSeconds(int sec) {
    final minutes = (sec ~/ 60).toString().padLeft(1, '0');
    final seconds = (sec % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
