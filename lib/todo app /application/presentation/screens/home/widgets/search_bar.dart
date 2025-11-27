import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controller/todo_controller.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    return Padding(
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
            Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp),
          ),
          trailing: [Icon(Iconsax.search_normal_14)],
        ),
      ),
    );
  }
}
