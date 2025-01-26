import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/core/utils/extensions.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/presentation/widgets/agent_tile.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_notifier.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class CompanyDetailsView extends StatelessWidget {
  final String companyId;
  const CompanyDetailsView({
    super.key,
    required this.companyId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final companyDetails = ref.watch(companyDetailsProvider(companyId));

        return RefreshIndicator(
          onRefresh: () =>
              ref.refresh(companyDetailsProvider(companyId).future),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: companyDetails.onData(
              whenData: (details) {
                return VStack(
                  [
                    _buildBasicDetails(context, details.company),
                    24.h.heightBox,
                    _buildAgentsCard(context, agents: details.relatedAgents),
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
                          title: Text("Delete Company").wFull(context),
                          content: Text(
                              "Selected Company will be deleted forever.."),
                        )) {
                          await ref
                              .read(companyNotifierProvider.notifier)
                              .deleteCompany(companyId);
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

  _buildBasicDetails(BuildContext context, CompanyEntity company) {
    return VStack(
      [
        VxBox(
          child: company.name[0].text
              .displayLarge(context)
              .color(context.colors.surface)
              .makeCentered(),
        )
            .make()
            .circle(
              radius: 160,
              backgroundColor: company.hexColor,
            )
            .hero('Company-${company.id}'),
        24.h.heightBox,
        company.name.text.headlineMedium(context).make(),
        2.h.heightBox,
        company.description.text
            .bodyLarge(context)
            .center
            .make()
            .pSymmetric(h: 4.w),
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).centered();
  }

  _buildAgentsCard(BuildContext context, {required List<AgentEntity> agents}) {
    if (agents.isEmpty) {
      return SizedBox();
    }
    return Card.filled(
      child: VStack(
        [
          "Agents Info".text.titleSmall(context).make().pOnly(left: 16.w),
          4.h.heightBox,
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: agents.length,
            itemBuilder: (context, index) {
              return AgentTile(
                isHeroEnabled: false,
                agent: agents[index],
              );
            },
          ),
        ],
      ).pOnly(top: 12.h, bottom: 8.h),
    ).wFull(context).pSymmetric(h: 8.w);
  }
}

class CompanyDetailsEntity {
  final CompanyEntity company;
  final List<AgentEntity> relatedAgents;

  CompanyDetailsEntity({
    required this.company,
    required this.relatedAgents,
  });
}

final companyDetailsProvider =
    FutureProvider.family<CompanyDetailsEntity, String>((ref, companyId) async {
  final database = ref.watch(databaseProvider);
  final company = await database.managers.companyTable
      .filter((f) => f.id.equals(companyId))
      .getSingle();

  final relatedAgentIds = (await database.managers.companyToAgentTable
          .filter((f) => f.companyId.id.equals(companyId))
          .get())
      .builder((m) => m.agentId);

  final relatedAgents = await database.managers.agentTable
      .filter((f) => f.id.isIn(relatedAgentIds))
      .orderBy((o) => o.name.asc())
      .get();

  return CompanyDetailsEntity(
    company: CompanyEntity.fromModel(company),
    relatedAgents: relatedAgents.builder(AgentEntity.fromModel),
  );
});
