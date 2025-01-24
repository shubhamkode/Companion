import 'package:companion/src/core/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentBasicDetailsSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController organizationController;

  const AgentBasicDetailsSection({
    super.key,
    required this.nameController,
    required this.organizationController,
  });

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        "Basic Details".text.labelSmall(context).make(),
        12.h.heightBox,
        TextFormField(
          decoration: getInputDecoration(
            hint: "John Doe",
            label: 'Name',
          ),
          controller: nameController,
          autofocus: true,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.words,
        ),
        8.h.heightBox,
        TextFormField(
          decoration: getInputDecoration(
            hint: "John Distributors",
            label: 'Organization\'s Name',
          ),
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: organizationController,
          textCapitalization: TextCapitalization.words,
        ),
      ],
    );
  }
}
