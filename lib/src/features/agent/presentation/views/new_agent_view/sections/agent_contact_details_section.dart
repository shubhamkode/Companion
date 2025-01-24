import 'package:companion/src/features/agent/presentation/widgets/contact_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentContactDetailsSection extends StatelessWidget {
  final List<TextEditingController> controllers;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;

  const AgentContactDetailsSection({
    super.key,
    required this.controllers,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        "Contact Details".text.labelSmall(context).make(),
        12.h.heightBox,
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controllers.length,
          itemBuilder: (context, index) {
            return ContactTextField(
              controller: controllers[index],
              key: Key(index.toString()),
              onRemove:
                  (controllers.length >= 2) ? () => onRemove(index) : null,
            );
          },
          separatorBuilder: (_, __) => 8.h.heightBox,
        ),
        8.h.heightBox,
        "Add Phone"
            .text
            .bold
            .color(context.colors.primary)
            .make()
            .pOnly(left: 4.w)
            .onTap(() {
          onAdd();
        }),
      ],
    );
  }
}
