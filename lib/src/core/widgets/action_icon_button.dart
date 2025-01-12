import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ActionIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String actionText;
  const ActionIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton.filledTonal(
          onPressed: onPressed,
          icon: Icon(icon).p(8),
        ),
        4.h.heightBox,
        actionText.text
            .titleSmall(context)
            .color(context.colors.onSurface.withAlpha(200))
            .medium
            .make(),
      ],
    );
  }
}
