import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/agent/domain/usecases/agent_usecase.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_notifier.dart';
import 'package:companion/src/features/agent/presentation/views/new_agent_view/sections/agent_basic_details_section.dart';
import 'package:companion/src/features/agent/presentation/views/new_agent_view/sections/agent_contact_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class NewAgentView extends ConsumerStatefulWidget {
  const NewAgentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewAgentViewState();
}

class _NewAgentViewState extends ConsumerState<NewAgentView> {
  final nameController = TextEditingController();
  final organizationController = TextEditingController();
  final List<TextEditingController> contactControllers = [
    TextEditingController(),
  ];

  Future<bool> saveContact() async {
    final String name = nameController.text.trim();
    final String organization = organizationController.text.trim();
    final List<String> contacts = contactControllers.builder((cnt) => cnt.text);

    await ref.read(agentNotifierProvider.notifier).createNewAgent(
          params: NewAgentParams(
            name: name,
            organization: organization,
            contacts: contacts,
          ),
        );

    return true;
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
      title: "New Agent".text.make(),
      actions: [
        FilledButton(
          onPressed: () async {
            //Todo- Add form validation
            if (await saveContact() && mounted) {
              context.maybePop();
            }
          },
          child: "Save".text.make(),
        ),
        16.w.widthBox,
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Form(
        child: VStack(
          [
            AgentBasicDetailsSection(
              nameController: nameController,
              organizationController: organizationController,
            ),
            AgentContactDetailsSection(
              controllers: contactControllers,
              onAdd: () {
                setState(() {
                  contactControllers.add(TextEditingController());
                });
              },
              onRemove: (int index) {
                setState(() {
                  contactControllers.removeAt(index);
                });
              },
            ),
          ],
          spacing: 24.h,
        ).pSymmetric(h: 16.w, v: 8.h),
      ),
    );
  }
}
