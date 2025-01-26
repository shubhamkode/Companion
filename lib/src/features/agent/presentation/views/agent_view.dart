import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/utils/extensions.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_notifier.dart';
import 'package:companion/src/features/agent/presentation/widgets/agents_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class AgentsView extends ConsumerWidget {
  const AgentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentProvider = ref.watch(agentNotifierProvider);

    return agentProvider.onData(
      whenData: (agents) {
        return VStack(
          [
            RefreshIndicator(
              onRefresh: () => ref.refresh(agentNotifierProvider.future),
              child: AgentsList(agents: agents),
            ).expand()
          ],
        );
      },
      whenEmpty: () {
        return "No Agents Found"
            .text
            .bodyLarge(context)
            .color(context.accentColor.withAlpha(200))
            .makeCentered();
      },
    );
  }
}
