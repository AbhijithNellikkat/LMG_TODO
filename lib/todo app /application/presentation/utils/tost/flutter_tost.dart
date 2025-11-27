import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/colors.dart';

void showCustomToast({
  required String message,
  Toast toastLength = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.SNACKBAR,
  int timeInSecForIosWeb = 3,
  double fontSize = 12.0,
  Color backgroundColor = kblack,
  Color textColor = kwhite,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
    timeInSecForIosWeb: timeInSecForIosWeb,
    fontSize: fontSize,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}
