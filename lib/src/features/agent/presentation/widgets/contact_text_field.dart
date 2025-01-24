import 'package:companion/src/core/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactTextField extends StatelessWidget {
  final VoidCallback? onRemove;
  final TextEditingController? controller;

  const ContactTextField({super.key, this.onRemove, this.controller});

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        TextFormField(
          decoration: getInputDecoration(
            label: 'Contact',
          ),
          controller: controller,
          style: context.titleLarge,
          keyboardType: TextInputType.phone,
        ).expand(),
        IconButton(
          onPressed: onRemove,
          icon: Icon(Icons.remove_circle_outline),
          color: context.colors.error,
          disabledColor: context.colors.error.withAlpha(150),
        ),
      ],
      axisSize: MainAxisSize.max,
    );
  }
}
