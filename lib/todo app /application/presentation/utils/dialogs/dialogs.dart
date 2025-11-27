import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';
import 'package:lmg_todo/application/presentation/widgets/loading_indicator.dart';

// Future<bool?> showExitDialog(BuildContext context) {
//   return showDialog<bool>(
//     context: context,
//     builder: (context) => AlertDialog(
//       elevation: 0,
//       surfaceTintColor: kblack,
//       backgroundColor: kwhite,
//       titleTextStyle: Theme.of(context).textTheme.displayMedium,
//       contentTextStyle: Theme.of(context).textTheme.displaySmall,
//       shadowColor: kblack,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       title: Text(
//         'Exit From Kathal',
//         style:
//             Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16.sp),
//       ),
//       content: Text(
//         'Are you sure you want to exit the app ?',
//         style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp),
//       ),
//       actionsAlignment: MainAxisAlignment.spaceAround,
//       actions: [
//         ElevatedButton(
//           onPressed: () => Navigator.of(context).pop(),
//           style: ElevatedButton.styleFrom(
//             fixedSize: const Size(100, 20),
//             elevation: 0,
//             backgroundColor: kwhite,
//             foregroundColor: knill,
//             surfaceTintColor: knill,
//             side: const BorderSide(color: kprimary),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24),
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//           ),
//           child: Text('Cancel',
//               style: Theme.of(context)
//                   .textTheme
//                   .displaySmall
//                   ?.copyWith(color: kprimary, fontSize: 13.sp)),
//         ),
//         // adjustWidth(10.w),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//             SystemNavigator.pop(); // Exit app
//           },
//           style: ElevatedButton.styleFrom(
//             fixedSize: const Size(100, 20),
//             elevation: 0,
//             backgroundColor: kprimary,
//             foregroundColor: knill,
//             surfaceTintColor: knill,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24),
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//           ),
//           child: Text('Exit',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodySmall
//                   ?.copyWith(fontSize: 13.sp, color: kwhite)),
//         )
//       ],
//     ),
//   );
// }

class CustomConfirmationDialog extends StatelessWidget {
  final String message;
  final String cancelText;
  final String confirmText;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String? image;
  final bool? showImage;
  final bool? loading;

  const CustomConfirmationDialog({
    super.key,
    required this.message,
    required this.cancelText,
    required this.confirmText,
    required this.onCancel,
    required this.onConfirm,
    this.showImage = false,
    this.loading = false,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    // If iOS → show Cupertino style
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: showImage == true && image != null
            ? Image.asset(image!, height: 100)
            : null,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: onCancel,
            isDefaultAction: false,
            child: Text(cancelText),
          ),
          CupertinoDialogAction(
            onPressed: loading == true ? null : onConfirm,
            isDefaultAction: true,
            child: loading == true
                ? const CupertinoActivityIndicator()
                : Text(confirmText),
          ),
        ],
      );
    }

    // Otherwise (Android, others) → show your custom dialog
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.14)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showImage == true)
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: kblack,
                    child: Icon(Icons.close, size: 18, color: kwhite),
                  ),
                ),
              ),
            if (showImage == true) Image.asset(image ?? '', height: 190.h),
            if (showImage == true) adjustHieght(7.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontSize: 15.sp),
            ),
            adjustHieght(23.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (showImage != true)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: kwhite,
                        foregroundColor: knill,
                        surfaceTintColor: knill,
                        side: const BorderSide(color: kprimary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                      child: Text(
                        cancelText,
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(color: kprimary, fontSize: 13.sp),
                      ),
                    ),
                  ),
                adjustWidth(10.w),
                Expanded(
                  child: loading == true
                      ? const CustomLoadingIndicator()
                      : ElevatedButton(
                          onPressed: onConfirm,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: kprimary,
                            foregroundColor: knill,
                            surfaceTintColor: knill,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                          ),
                          child: Text(
                            confirmText,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontSize: 13.sp, color: kwhite),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
