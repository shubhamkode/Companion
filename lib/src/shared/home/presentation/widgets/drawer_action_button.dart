import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerActionButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final IconData icon;
  final VoidCallback? onTap;

  const DrawerActionButton({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      selected: isSelected,
      leading: Icon(icon),
      selectedTileColor: context.colors.primary,
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      selectedColor: context.colors.onPrimary,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      title: title.text
          .titleSmall(context)
          .semiBold
          .size(14.sp)
          .color(
            isSelected
                ? context.colors.onPrimary
                : context.colors.onPrimaryContainer,
          )
          .make(),
    );
  }
}
