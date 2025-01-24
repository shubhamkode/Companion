import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/core/utils/extensions.dart';
import 'package:companion/src/core/utils/make_call.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_notifier.dart';
import 'package:companion/src/features/agent/presentation/widgets/contact_tile.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class AgentDetailsView extends StatelessWidget {
  final String agentId;
  const AgentDetailsView({super.key, required this.agentId});

  @override
  Widget build(BuildContext context) {
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
      builder: (context, ref, _) {
        final agentDetails = ref.watch(agentDetailsProvider(agentId));
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(agentDetailsProvider);
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: agentDetails.onData(
              whenData: (details) {
                return VStack(
                  [
                    _buildBasicDetails(
                      context,
                      agent: details.agent,
                    ),
                    12.h.heightBox,
                    _buildActions(context, details: details),
                    12.h.heightBox,
                    _buildContactsCard(
                      context,
                      contacts: details.agent.contacts,
                    ),
                    4.h.heightBox,
                    _buildCompanies(
                      context,
                      companies: details.linkedCompanies,
                    ),
                    12.h.heightBox,
                    Divider(),
                    ListTile(
                      minTileHeight: 0,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 24.w),
                      leading: Icon(
                        Icons.edit_outlined,
                      ),
                      onTap: () {},
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
                          content: Text(
                              "Selected contact will be deleted forever.."),
                        )) {
                          await ref
                              .read(agentNotifierProvider.notifier)
                              .deleteAgent(agentId);
                          if (context.mounted) {
                            context.maybePop();
                          }
                        }
                      },
                      title: "Delete".text.color(context.colors.error).make(),
                    ),
                    Divider(),
                    4.h.heightBox,
                  ],
                ).pOnly(top: 12.h, bottom: 40.h);
              },
            ),
          ),
        );
      },
    );
  }

  _buildBasicDetails(
    BuildContext context, {
    required AgentEntity agent,
  }) {
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
  }

  _buildContactsCard(
    BuildContext context, {
    required List<String> contacts,
  }) {
    if (contacts.isEmpty) {
      return SizedBox();
    }
    return Card.filled(
      child: VStack(
        [
          "Contact Info".text.titleSmall(context).make().pOnly(left: 16.w),
          4.h.heightBox,
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return ContactTile(
                contact: contacts[index],
                isPrimary: index == 0,
              );
            },
          ),
        ],
      ).pOnly(top: 12.h, bottom: 8.h),
    ).wFull(context).pSymmetric(h: 8.w);
  }

  _buildCompanies(
    BuildContext context, {
    required List<CompanyEntity> companies,
  }) {
    if (companies.isEmpty) {
      return SizedBox();
    }

    return Card.filled(
      child: VStack(
        [
          "Companies".text.titleSmall(context).make().pOnly(left: 16.w),
          4.h.heightBox,
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return ListTile(
                contentPadding: EdgeInsets.only(left: 20.w, right: 12.w),
                leading: CircleAvatar(
                  backgroundColor: company.hexColor,
                  child: company.name[0].text
                      .titleLarge(context)
                      .color(context.colors.surface)
                      .make(),
                ),
                title: company.name.text.make(),
                subtitle: company.description.text.maxLines(1).make(),
              );
            },
          ),
        ],
      ).pOnly(top: 12.h, bottom: 8.h),
    ).wFull(context).pSymmetric(h: 8.w);
  }

  _buildActions(
    BuildContext context, {
    required AgentDetailsEntity details,
  }) {
    return HStack(
      [
        VStack(
          [
            IconButton.filledTonal(
              onPressed: () async {
                await makeCallTo(details.agent.contacts[0]);
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
}

class AgentDetailsEntity {
  final AgentEntity agent;
  final List<CompanyEntity> linkedCompanies;

  AgentDetailsEntity({
    required this.agent,
    required this.linkedCompanies,
  });
}

final agentDetailsProvider = FutureProvider.family<AgentDetailsEntity, String>(
  (ref, agentId) async {
    final database = ref.watch(databaseProvider);

    final agent = await database.managers.agentTable
        .filter((f) => f.id.equals(agentId))
        .getSingle();

    final linkedCompanyIds = (await database.managers.companyToAgentTable
            .filter((f) => f.agentId.id.equals(agent.id))
            .get())
        .builder((lc) => lc.companyId);

    final linkedCompanies = await database.managers.companyTable
        .filter((f) => f.id.isIn(linkedCompanyIds))
        .get();

    return AgentDetailsEntity(
      agent: AgentEntity.fromModel(agent),
      linkedCompanies: linkedCompanies.builder(CompanyEntity.fromModel),
    );
  },
);
