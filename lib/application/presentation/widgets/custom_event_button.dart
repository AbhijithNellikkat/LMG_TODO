import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';

class CustomEventButton extends StatelessWidget {
  const CustomEventButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.hieght,
    this.textColr,
    this.textStyle,
    this.color,
    this.borderRadius,
    this.showGradiant = true,
    this.outlineBorder = false,
    this.shadow = true,
    this.outlineBorderClr,
    this.padding,
    this.margin,
    this.icon,
    this.clr,
  });

  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? hieght;
  final Color? textColr;
  final Gradient? color;
  final double? borderRadius;
  final TextStyle? textStyle;
  final bool showGradiant;
  final bool shadow;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? outlineBorderClr;
  final bool outlineBorder;
  final Color? clr;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        width: width ?? 150,
        height: hieght ?? 45,
        decoration: BoxDecoration(
          border: outlineBorder
              ? Border.all(color: outlineBorderClr ?? kblack)
              : null,

          gradient: showGradiant ? (color) : null,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 35)),
          color: clr ?? Theme.of(context).scaffoldBackgroundColor,

          boxShadow: shadow
              ? [
                  BoxShadow(
                    color: const Color(0xFF5F33E1).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Icon(icon, color: textColr ?? kwhite, size: 20.sp)
                  : const SizedBox(),
              icon != null ? SizedBox(width: 8.w) : const SizedBox(),
              Text(
                text,
                style:
                    textStyle ??
                    Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: textColr ?? kwhite,
                      fontSize: 14.sp,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
