import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_notifier.dart';
import 'package:companion/src/features/agent/presentation/widgets/agents_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class AgentsView extends ConsumerWidget {
  const AgentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentProvider = ref.watch(agentNotifierProvider);

    return agentProvider.when(
      error: (err, stack) => err.toString().text.makeCentered(),
      loading: () {
        return _buildLoading(context);
      },
      data: (agents) {
        if (agents.isEmpty) {
          return "No Agents Found"
              .text
              .bodyLarge(context)
              .color(context.accentColor.withAlpha(200))
              .makeCentered();
        }
        return VStack(
          [
            RefreshIndicator(
              onRefresh: () => ref.refresh(agentNotifierProvider.future),
              child: AgentsList(agents: agents),
            ).expand()
          ],
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: 4.w, bottom: 50.h),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar().shimmer(),
          title: VxSkeleton(
            height: 12.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer(),
          subtitle: VxSkeleton(
            height: 8.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer(),
        );
      },
    );
  }
}
