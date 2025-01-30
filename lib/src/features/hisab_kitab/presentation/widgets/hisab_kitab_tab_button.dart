import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class HisabKitabTabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const HisabKitabTabButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 200,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isSelected
            ? context.colors.primaryContainer
            : context.colors.secondaryContainer,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: title.text
          .labelLarge(context)
          .color(
            isSelected
                ? context.colors.onPrimaryContainer
                : context.colors.secondary,
          )
          .make(),
    ).onTap(onTap);
  }
}
