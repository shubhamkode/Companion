import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/features/agent/presentation/widgets/agent_tile.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_details_notifier.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_notifier.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class CompanyDetailsView extends StatelessWidget {
  const CompanyDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Consumer(
      builder: (context, ref, child) {
        return RefreshIndicator(
          onRefresh: () => ref.refresh(companyDetailsNotifierProvider.future),
          child: child!,
        );
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: VStack(
          [
            CompanyBasicDetailsSection(),
            CompanyAgentsCard(),
            VStack([
              Divider(),
              _buildSecondaryActions(),
              Divider(),
            ])
          ],
          spacing: 12.h,
        ).pOnly(top: 12.h, bottom: 40.h),
      ),
    );
  }

  Widget _buildSecondaryActions() {
    return Consumer(
      builder: (context, ref, child) {
        final companyProvider = ref.watch(
          companyDetailsNotifierProvider.selectAsync(
            (s) => s.company,
          ),
        );

        return VStack(
          [
            ListTile(
              minTileHeight: 0,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 4.h, horizontal: 24.w),
              leading: Icon(
                Icons.edit_outlined,
              ),
              onTap: () async {
                context.pushRoute(
                  CompanyEditRoute(
                    company: await companyProvider,
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
                      .read(companyNotifierProvider.notifier)
                      .deleteCompany();
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

class CompanyBasicDetailsSection extends ConsumerWidget {
  const CompanyBasicDetailsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyDetailsProvider = ref.watch(
      companyDetailsNotifierProvider.select(
        (s) => s.whenData((c) => c.company),
      ),
    );

    return companyDetailsProvider.when(
      error: (err, stack) => SizedBox.shrink(),
      loading: () {
        return _buildLoading(context);
      },
      data: (company) {
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
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return VStack(
      [
        VxBox().make().circle(radius: 160).shimmer(),
        24.h.heightBox,
        skeleton(
          height: 24.h,
          width: context.percentWidth * 80,
          borderRadius: BorderRadius.circular(8.r),
        ).shimmer(),
        8.h.heightBox,
        skeleton(
          height: 12.h,
          width: context.percentWidth * 70,
          borderRadius: BorderRadius.circular(8.r),
        ).shimmer(),
        2.h.heightBox,
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).centered();
  }
}

class CompanyAgentsCard extends ConsumerWidget {
  const CompanyAgentsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkedAgents = ref.watch(
      companyDetailsNotifierProvider.select(
        (s) => s.whenData((c) => c.relatedAgents),
      ),
    );

    return linkedAgents.when(
      error: (err, stack) => SizedBox.shrink(),
      loading: () => _buildCard(
        context,
        child: _buildLoading(context),
      ),
      data: (agents) {
        if (agents.isEmpty) {
          return SizedBox.shrink();
        }
        return _buildCard(
          context,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: agents.length,
            itemBuilder: (context, index) {
              return AgentTile(
                isHeroEnabled: false,
                agent: agents[index],
              ).pOnly(left: 8.w);
            },
          ),
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return ListTile(
          minTileHeight: 0,
          contentPadding: EdgeInsets.only(
            left: 16.w,
            bottom: 2.h,
            top: 2.h,
            right: 12.w,
          ),
          leading: CircleAvatar().shimmer(),
          title: VxSkeleton(
            height: 12.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer().pOnly(bottom: 8.h),
          subtitle: VxSkeleton(
            height: 8.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer().pOnly(right: context.percentWidth * 50),
        );
      },
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required Widget child,
  }) {
    return Card.filled(
      child: VStack(
        [
          "Agents".text.titleSmall(context).make().pOnly(left: 16.w),
          4.h.heightBox,
          child,
        ],
      ).pOnly(top: 12.h, bottom: 8.h),
    ).wFull(context).pSymmetric(h: 8.w);
  }
}
