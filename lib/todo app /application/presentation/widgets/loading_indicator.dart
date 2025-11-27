import 'package:flutter/cupertino.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double radius;
  final Color? color;
  final String? loadingText;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const CustomLoadingIndicator({
    super.key,
    this.radius = 15.0,
    this.color,
    this.loadingText,
    this.textStyle,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoActivityIndicator(radius: radius, color: color),
            if (loadingText != null) ...[
              const SizedBox(height: 10),
              Text(
                loadingText!,
                style: textStyle ?? const TextStyle(fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
