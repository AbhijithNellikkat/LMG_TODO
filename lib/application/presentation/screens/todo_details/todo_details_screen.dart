import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';

class ScreenTodoDetails extends StatefulWidget {
  const ScreenTodoDetails({super.key});

  @override
  State<ScreenTodoDetails> createState() => _ScreenTodoDetailsState();
}

class _ScreenTodoDetailsState extends State<ScreenTodoDetails> {
  // Dummy Data
  String title = "Morning Exercise";
  String description =
      "Complete 10 mins workout including stretching and warm-up.";
  String status = "Pending";
  int totalSeconds = 150; // 2 min 30 sec dummy time
  late int remainingSeconds;

  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    remainingSeconds = totalSeconds;
  }

  String formatTime(int sec) {
    final minutes = (sec ~/ 60).toString().padLeft(2, '0');
    final seconds = (sec % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void startTimer() {
    if (isRunning) return;

    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          isRunning = false;
          status = "Completed";
        });
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
      remainingSeconds = totalSeconds;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: klightgrey),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Icon(Icons.arrow_back_ios, size: 18.sp),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Todo Details",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: klightgrey),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Icon(Iconsax.edit, size: 18.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              adjustHieght(20.h),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: kprimary,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Text(
                    "Status: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Chip(
                    label: Text(status),
                    backgroundColor: status == "Completed"
                        ? Colors.green.shade200
                        : Colors.orange.shade200,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text(
                description,
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),

              const SizedBox(height: 30),

              Center(
                child: Text(
                  formatTime(remainingSeconds),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.stop_circle, size: 40),
                    color: Colors.red,
                    onPressed: stopTimer,
                  ),
                  const SizedBox(width: 20),

                  IconButton(
                    icon: const Icon(Iconsax.pause_circle, size: 40),
                    color: Colors.orange,
                    onPressed: pauseTimer,
                  ),

                  const SizedBox(width: 20),

                  IconButton(
                    icon: const Icon(Iconsax.play_circle, size: 40),
                    color: Colors.green,
                    onPressed: startTimer,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
