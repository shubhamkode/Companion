import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/presentation/widgets/agent_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentsList extends ConsumerWidget {
  final List<AgentEntity> agents;
  const AgentsList({
    super.key,
    required this.agents,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: 4.w, bottom: 50.h),
      itemCount: agents.length,
      itemBuilder: (context, index) {
        return AgentTile(
          agent: agents[index],
        );
      },
    );
  }
}
