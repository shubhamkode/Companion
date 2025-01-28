import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/domain/usecases/agent_usecase.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_notifier.dart';
import 'package:companion/src/features/agent/presentation/views/new_agent_view/sections/agent_basic_details_section.dart';
import 'package:companion/src/features/agent/presentation/views/new_agent_view/sections/agent_contact_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class AgentEditView extends ConsumerStatefulWidget {
  final AgentEntity agent;
  const AgentEditView({
    super.key,
    required this.agent,
  });

  @override
  ConsumerState<AgentEditView> createState() => _AgentEditViewState();
}

class _AgentEditViewState extends ConsumerState<AgentEditView> {
  final _nameController = TextEditingController();
  final _organizationController = TextEditingController();

  List<TextEditingController> _contactControllers = [];

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.agent.name;
    _organizationController.text = widget.agent.organization;

    _contactControllers = List.generate(
      widget.agent.contacts.length,
      (index) {
        return TextEditingController(text: widget.agent.contacts[index]);
      },
    );
  }

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
      title: "Edit Agent".text.make(),
      actions: [
        FilledButton(
          onPressed: () async {
            //Todo- Add form validation
            if (await updateContact() && mounted) {
              context.maybePop();
            }
          },
          child: "Update".text.make(),
        ),
        16.w.widthBox,
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: VStack(
          [
            AgentBasicDetailsSection(
              nameController: _nameController,
              organizationController: _organizationController,
            ),
            AgentContactDetailsSection(
              controllers: _contactControllers,
              onAdd: () {
                setState(() {
                  _contactControllers.insert(
                    0,
                    TextEditingController(),
                  );
                });
              },
              onRemove: (index) {
                setState(() {
                  _contactControllers.removeAt(index);
                });
              },
            ),
          ],
          spacing: 24.h,
        ).pSymmetric(h: 16.w, v: 8.h),
      ),
    );
  }

  Future<bool> updateContact() async {
    await ref.read(agentNotifierProvider.notifier).updateAgent(
          UpdateAgentParams(
            id: widget.agent.id,
            name: _nameController.text,
            organization: _organizationController.text,
            contacts: _contactControllers.builder((cnt) => cnt.text),
          ),
        );
    return true;
  }
}
