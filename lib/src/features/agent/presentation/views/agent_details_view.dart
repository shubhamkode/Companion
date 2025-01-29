import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/core/utils/make_call.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_details_notifier.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_notifier.dart';
import 'package:companion/src/features/agent/presentation/widgets/agent_details_view/agent_companies_card.dart';
import 'package:companion/src/features/agent/presentation/widgets/agent_details_view/agent_contacts_card.dart';
import 'package:companion/src/features/agent/presentation/widgets/agent_details_view/agent_detail_section.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class AgentDetailsView extends ConsumerWidget {
  const AgentDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.surface,
    );
  }

  _buildBody(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // final agentDetails = ref.watch(agentDetailsNotifierProvider);
        return RefreshIndicator(
          onRefresh: () => ref.refresh(agentDetailsNotifierProvider.future),
          child: child!,
        );
      },
      child: SingleChildScrollView(
        child: VStack(
          [
            AgentDetailSection(),
            _buildPrimaryActions(),
            VStack(
              [
                AgentContactsCard(),
                AgentCompaniesCard(),
              ],
              spacing: 4.h,
            ),
            VStack(
              [
                Divider(),
                _buildActions(),
                Divider(),
              ],
              spacing: 4.h,
            )
          ],
          spacing: 12.h,
        ).pOnly(
          top: 12.h,
          bottom: 40.h,
        ),
      ),
    );
  }

  _buildPrimaryActions() {
    return Consumer(builder: (context, ref, child) {
      final Future<String> primaryContact = ref.watch(
        agentDetailsNotifierProvider.selectAsync(
          (s) => s.agent.contacts[0],
        ),
      );

      return HStack(
        [
          VStack(
            [
              IconButton.filledTonal(
                onPressed: () async {
                  await makeCallTo(await primaryContact);
                },
                icon: Icon(Icons.call_outlined),
                iconSize: 18.sp,
              ),
              "Call".text.labelSmall(context).semiBold.make(),
            ],
            crossAlignment: CrossAxisAlignment.center,
          )
        ],
        spacing: 30.w,
        axisSize: MainAxisSize.max,
        alignment: MainAxisAlignment.center,
        // spacing: 40.w,
      ).wFull(context);
    });
  }

  Widget _buildActions() {
    return Consumer(
      builder: (context, ref, child) {
        final agentProvider = ref.watch(
          agentDetailsNotifierProvider.selectAsync(
            (s) => s.agent,
          ),
        );

        return VStack(
          [
            ListTile(
              minTileHeight: 0,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 4.h, horizontal: 24.w),
              leading: Icon(
                Icons.add_business_outlined,
              ),
              onTap: () {
                context.pushRoute(
                  CompanyToAgentRoute(),
                );
              },
              title: "Link or Unlink Company".text.make(),
            ),
            ListTile(
              minTileHeight: 0,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 4.h, horizontal: 24.w),
              leading: Icon(
                Icons.edit_outlined,
              ),
              onTap: () async {
                context.pushRoute(
                  AgentEditRoute(
                    agent: await agentProvider,
                  ),
                );
              },
              title: "Edit".text.make(),
            ),
            ListTile(
              minTileHeight: 0,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 4.h, horizontal: 24.w),
              leading: Icon(
                Icons.delete_outline,
                color: context.colors.error,
              ),
              onTap: () async {
                if (await confirm(
                  context,
                  title: Text("Delete Contact").wFull(context),
                  content: Text("Selected contact will be deleted forever.."),
                )) {
                  await ref.read(agentNotifierProvider.notifier).deleteAgent();
                  if (context.mounted) {
                    context.maybePop();
                  }
                }
              },
              title: "Delete".text.color(context.colors.error).make(),
            ),
          ],
        );
      },
    );
  }
}
