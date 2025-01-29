import 'package:companion/src/features/agent/presentation/notifiers/agent_details_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentDetailSection extends ConsumerWidget {
  const AgentDetailSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentBasicDetailsProvider = ref.watch(
      agentDetailsNotifierProvider.select(
        (s) => s.whenData(
          (a) => a.agent,
        ),
      ),
    );

    return agentBasicDetailsProvider.when(
      error: (error, stackTrace) {
        return SizedBox.shrink();
      },
      loading: () => _buildLoading(context),
      data: (agent) {
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
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return VStack(
      [
        VxBox().make().circle(radius: 160).shimmer(),
        24.h.heightBox,
        skeleton(
          height: 24.h,
          width: context.percentWidth * 80,
          borderRadius: BorderRadius.circular(8.r),
        ).shimmer(),
        8.h.heightBox,
        skeleton(
          height: 12.h,
          width: context.percentWidth * 70,
          borderRadius: BorderRadius.circular(8.r),
        ).shimmer(),
        2.h.heightBox,
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).centered();
  }
}
