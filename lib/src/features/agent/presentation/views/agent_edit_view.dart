import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class AgentEditView extends StatefulWidget {
  final AgentEntity agent;
  const AgentEditView({
    super.key,
    required this.agent,
  });

  @override
  State<AgentEditView> createState() => _AgentEditViewState();
}

class _AgentEditViewState extends State<AgentEditView> {
  final _nameController = TextEditingController();
  final _organizationController = TextEditingController();

  final List<TextEditingController> _contactControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.surface,
      titleSpacing: 0,
      title: "New Agent".text.make(),
      actions: [
        FilledButton(
          onPressed: () async {
            //Todo- Add form validation
            // if (await saveContact() && mounted) {
            //   context.maybePop();
            // }
          },
          child: "Update".text.make(),
        ),
        16.w.widthBox,
      ],
    );
  }

  _buildBody() {}
}
