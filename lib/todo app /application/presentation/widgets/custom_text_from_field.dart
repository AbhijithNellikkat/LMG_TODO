import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/colors.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/validators/validation_textfield.dart';

import '../utils/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool obscureText;
  final VoidCallback? function;
  final VoidCallback? onTapOutside;
  final int? maxlegth;
  final double? height;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Color? clr;
  final Function(String value)? onChanaged;
  final Function(String? value)? onSubmitted;
  final VoidCallback? onTap;
  final TextEditingController? password;
  final FocusNode? focusNode;
  final bool showUnderline;
  final Validate validate;
  final TextCapitalization textCapitalization;
  final bool enabled;
  final double textSize;
  final double? padding;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final BorderRadius? borderRadius;
  const CustomTextFormField({
    super.key,
    this.padding,
    this.borderRadius,
    this.inputFormatters,
    this.enabled = true,
    this.prefix,
    this.onSubmitted,
    this.validate = Validate.none,
    this.password,
    this.showUnderline = false,
    this.clr,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.inputType = TextInputType.name,
    this.obscureText = false,
    this.maxlegth,
    this.height,
    this.maxLines,
    this.function,
    this.onTap,
    this.onChanaged,
    this.focusNode,
    this.hintText,
    this.textSize = 0.033,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onTapOutside,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  // final FocusNode _focusNode = FocusNode();

  bool showEye = false;

  @override
  void initState() {
    super.initState();
    showEye = widget.obscureText;
    // _focusNode.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        autofocus: false,
        onTapOutside: (event) {
          if (widget.onTapOutside != null) {
            widget.onTapOutside!();
          }
        },
        enabled: widget.enabled,
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        textCapitalization: widget.textCapitalization,
        maxLines: widget.maxLines ?? 1,
        style: Theme.of(context).textTheme.bodySmall,
        maxLength: widget.maxlegth,
        onChanged: widget.onChanaged,
        autovalidateMode: widget.autovalidateMode,
        onSaved: widget.onSubmitted,
        obscureText: showEye,
        controller: widget.controller,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          fillColor: kgrey.withOpacity(0.1),
          counter: const SizedBox.shrink(),
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showEye = !showEye;
                    });
                  },
                  icon: Icon(showEye ? Iconsax.eye_slash : Iconsax.eye),
                )
              : widget.suffixIcon,
          prefix: widget.prefix,
          prefixIcon: widget.prefixIcon,
          filled: true,
          hintText: widget.hintText,
          errorMaxLines: widget.maxLines,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: kdarkgrey),
          labelText: widget.hintText != null ? null : widget.labelText,
          border: widget.showUnderline
              ? UnderlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(7),
                )
              : OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius20,
                  borderSide: BorderSide(color: kgrey.withOpacity(0.3)),
                ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? kBorderRadius20,
            borderSide: const BorderSide(color: kprimary, width: 1),
          ),
          errorBorder: widget.showUnderline
              ? UnderlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius20,
                  borderSide: const BorderSide(color: kred, width: 1),
                )
              : OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius20,
                  borderSide: const BorderSide(color: kred, width: 1),
                ),
          focusedErrorBorder: widget.showUnderline
              ? UnderlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius20,
                  borderSide: const BorderSide(color: kred, width: 1),
                )
              : OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius20,
                  borderSide: const BorderSide(color: kred, width: 1),
                ),
          enabledBorder: widget.showUnderline
              ? const UnderlineInputBorder(borderSide: BorderSide(color: kgrey))
              : OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? kBorderRadius20,
                  borderSide: const BorderSide(color: knill, width: 1),
                ),
        ),
        validator: (value) {
          return ValidationTextField.validateTextField(
            validate: widget.validate,
            labelText: widget.labelText,
            value: value,
            password: widget.password?.text,
          );
        },
      ),
    );
  }
}
