import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';

import '../../widgets/custom_event_button.dart';

class ErrorRefreshIndicator extends StatelessWidget {
  const ErrorRefreshIndicator({
    super.key,
    this.shrinkWrap = false,
    // required this.onTap,
    this.scroll = false,
    required this.onRefresh,
    this.errorMessage =
        "Oops! Something went wrong. Please tap 'Try Again' to retry.",
    this.image,
    this.showTryAgain = true,
    this.textAnimate = false,
  });

  final VoidCallback onRefresh;
  // final VoidCallback onTap;
  final String errorMessage;
  final bool shrinkWrap;
  final bool showTryAgain;
  final String? image;
  final bool scroll;
  final bool textAnimate;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
        await Future.delayed(const Duration(milliseconds: 1500));
      },
      child: FadeIn(
        animate: true,
        child: ListView(
          physics: scroll
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          shrinkWrap: shrinkWrap,
          children: [
            // adjustHieght(0),
            image != null
                ? Image.asset(image!)
                : const Icon(Icons.refresh, color: kgrey),
            textAnimate == true
                ? AnimatedTextKit(
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      TyperAnimatedText(
                        errorMessage,
                        textStyle: Theme.of(
                          context,
                        ).textTheme.displaySmall?.copyWith(fontSize: 13.sp),
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 60),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      errorMessage,
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall?.copyWith(fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
            adjustHieght(15.h),
            if (showTryAgain)
              Center(
                child: CustomEventButton(
                  textColr: Get.isDarkMode ? kblack : kwhite,
                  color: LinearGradient(
                    colors: Get.isDarkMode
                        ? [kblack, kblack]
                        : [kblack, kblack],
                  ),
                  text: 'Try Again',
                  onTap: onRefresh,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
