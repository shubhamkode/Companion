import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/core/utils/extensions.dart';
import 'package:companion/src/core/utils/make_call.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_details_notifier.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_id_provider.dart';
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
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(cardOpenProvider.notifier).update((state) => false);
          ref.read(agentIdProvider.notifier).update((state) => "");
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
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
      builder: (context, ref, _) {
        final agentDetails = ref.watch(agentDetailsNotifierProvider);
        return RefreshIndicator(
          onRefresh: () => ref.refresh(agentDetailsNotifierProvider.future),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: agentDetails.onData(
              whenData: (details) {
                return VStack(
                  [
                    AgentDetailSection(
                      agent: details.agent,
                    ),
                    FadeIn(
                      child: _buildPrimaryActions(
                        context,
                        primaryContact: details.agent.contacts[0],
                      ),
                    ),
                    VStack(
                      [
                        FadeIn(
                          child: AgentContactsCard(
                            contacts: details.agent.contacts,
                          ),
                        ),
                        if (details.linkedCompanies.isNotEmpty)
                          FadeIn(
                            child: AgentCompaniesCard()
                                .wFull(context)
                                .pSymmetric(h: 8.w),
                          ),
                      ],
                      spacing: 4.h,
                    ),
                    Divider(),
                    _buildActions(
                      agent: details.agent,
                    ),
                    Divider(),
                  ],
                  spacing: 12.h,
                ).pOnly(top: 12.h, bottom: 40.h);
              },
            ),
          ),
        );
      },
    );
  }

  _buildPrimaryActions(
    BuildContext context, {
    required String primaryContact,
  }) {
    return HStack(
      [
        VStack(
          [
            IconButton.filledTonal(
              onPressed: () async {
                await makeCallTo(primaryContact);
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
  }

  Widget _buildActions({
    required AgentEntity agent,
  }) {
    return Consumer(
      builder: (context, ref, child) {
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
              onTap: () {
                context.pushRoute(
                  AgentEditRoute(
                    agent: agent,
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
                  await ref
                      .read(agentNotifierProvider.notifier)
                      .deleteAgent(ref.read(agentIdProvider));
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

final cardOpenProvider = StateProvider<bool>((ref) {
  return false;
});
