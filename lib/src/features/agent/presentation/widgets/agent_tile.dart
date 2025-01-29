import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/core/utils/make_call.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentTile extends ConsumerWidget {
  final AgentEntity agent;
  final bool isHeroEnabled;
  const AgentTile({
    super.key,
    required this.agent,
    this.isHeroEnabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: HeroMode(
        enabled: isHeroEnabled,
        child: CircleAvatar(
          backgroundColor: agent.hexColor,
          child: agent.name[0].text
              .titleLarge(context)
              .color(context.colors.surface)
              .make(),
        ).onTap(() {
          _navigateToAgentDetailsPage(context, ref);
        }).hero('Agent-${agent.id}'),
      ),
      title: agent.name.text.make().onTap(() {
        _navigateToAgentDetailsPage(context, ref);
      }),
      subtitle: agent.organization.text.make(),
      trailing: IconButton(
        onPressed: () async {
          await makeCallTo(agent.contacts[0]);
        },
        icon: Icon(Icons.call_outlined),
      ),
    );
  }

  _navigateToAgentDetailsPage(BuildContext context, WidgetRef ref) {
    ref.read(agentIdProvider.notifier).update((state) => agent.id);
    context.pushRoute(
      AgentDetailsRoute(),
    );
  }
}
