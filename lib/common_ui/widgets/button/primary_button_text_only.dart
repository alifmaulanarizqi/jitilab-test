import 'package:flutter/material.dart';

import '../../utils/colors/common_colors.dart';
import '../../utils/text_style/common_text_style.dart';

class PrimaryButtonTextOnly extends StatelessWidget {
  final Function() onTap;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double? customHeight;
  final double? fontSize;
  final double? horizontalPadding;
  final Widget? icon;
  final double? verticalPadding;
  final double? customWidth;
  final double borderRadius;
  final bool isActive;
  final Color? borderColor;

  const PrimaryButtonTextOnly(
      {Key? key,
        required this.onTap,
        required this.label,
        required this.isActive,
        this.backgroundColor,
        this.textColor,
        this.customHeight,
        this.icon,
        this.fontSize = 20,
        this.borderRadius = 4,
        this.horizontalPadding,
        this.verticalPadding,
        this.customWidth,
        this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive
          ? backgroundColor ?? CommonColors.blueB5
          : CommonColors.greyD1,
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (isActive) {
            onTap();
          }
        },
        borderRadius: const BorderRadius.all(
          Radius.circular(
            4,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 36,
            vertical: verticalPadding ?? 6,
          ),
          child: SizedBox(
            height: customHeight ?? 36,
            width: customWidth,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: icon != null,
                      child: icon ?? const SizedBox.shrink()),
                  Visibility(
                      visible: icon != null,
                      child: const SizedBox(
                        width: 8,
                      ) ??
                          const SizedBox.shrink()),
                  Text(
                    label,
                    style: CommonTypography.roboto14.copyWith(
                      color: textColor ?? Colors.white,
                      fontSize: fontSize ?? 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}