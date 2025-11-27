import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lmg_todo/application/presentation/screens/home/widgets/header_with_carousel.dart';
import 'package:lmg_todo/application/presentation/screens/home/widgets/search_bar.dart';
import 'package:lmg_todo/application/presentation/screens/home/widgets/todos_list.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(screenBgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              adjustHieght(30.h),
              HeaderWithCarousel(),
              adjustHieght(20.h),
              SearchBarWidget(),
              adjustHieght(10.h),
              TodosList(),
            ],
          ),
        ),
      ),
    );
  }
}
