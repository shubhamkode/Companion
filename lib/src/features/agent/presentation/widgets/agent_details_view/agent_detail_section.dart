import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentDetailSection extends StatelessWidget {
  final AgentEntity agent;
  const AgentDetailSection({
    super.key,
    required this.agent,
  });

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        VxBox(
          child: agent.name[0].text
              .displayLarge(context)
              .color(context.colors.surface)
              .makeCentered(),
        )
            .make()
            .circle(
              radius: 160,
              backgroundColor: agent.hexColor,
            )
            .hero('Agent-${agent.id}'),
        24.h.heightBox,
        agent.name.text.headlineMedium(context).make(),
        2.h.heightBox,
        agent.organization.text.bodyLarge(context).make(),
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).centered();
  }
}