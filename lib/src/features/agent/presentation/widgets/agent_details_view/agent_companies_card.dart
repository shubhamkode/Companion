import 'dart:developer';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_details_notifier.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentCompaniesCard extends ConsumerStatefulWidget {
  const AgentCompaniesCard({super.key});

  @override
  ConsumerState<AgentCompaniesCard> createState() => _AgentCompaniesCardState();
}

class _AgentCompaniesCardState extends ConsumerState<AgentCompaniesCard> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final linkedCompaniesProvider = ref.watch(
      agentDetailsNotifierProvider.select(
        (s) => s.whenData((c) => c.linkedCompanies),
      ),
    );

    return linkedCompaniesProvider.when(
      error: (err, stack) {
        log(err.toString());
        log(stack.toString());
        return SizedBox();
      },
      loading: () {
        return _buildCard(
          context,
          child: _buildLoading(context),
        );
      },
      data: (linkedCompanies) {
        // return _buildCard(
        //   context,
        //   child: _buildLoading(context),
        // );
        if (linkedCompanies.isEmpty) {
          return SizedBox.shrink();
        }
        return _buildCard(
          context,
          child: VStack(
            [
              ImplicitlyAnimatedList<CompanyEntity>(
                key: listKey,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                items: (linkedCompanies.length < 2)
                    ? linkedCompanies
                    : (isExpanded)
                        ? linkedCompanies
                        : linkedCompanies.take(2).toList(),
                itemBuilder: (context, animation, item, index) {
                  return FadeTransition(
                    opacity: animation,
                    child: _buildCompanyTile(context, item),
                  );
                },
                removeDuration: Duration(milliseconds: 300),
                removeItemBuilder: (context, animation, item) {
                  return FadeTransition(
                    opacity: animation,
                    child: _buildCompanyTile(
                      context,
                      item,
                    ),
                  );
                },
                areItemsTheSame: (a, b) => a.id == b.id,
              ),
              if (linkedCompanies.length > 2)
                Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: ListTile(
                    minTileHeight: 0,
                    minVerticalPadding: 12.h,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    trailing: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_outlined
                          : Icons.keyboard_arrow_down_outlined,
                      color: context.colors.inverseSurface,
                    ),
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                      // ref
                      //     .read(cardOpenProvider.notifier)
                      //     .update((state) => !state);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompanyTile(
    BuildContext context,
    CompanyEntity company,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20.w, right: 12.w),
      minTileHeight: 0,
      leading: CircleAvatar(
        backgroundColor: company.hexColor,
        child: company.name[0].text
            .titleLarge(context)
            .color(context.colors.surface)
            .make(),
      ),
      title: company.name.text.make(),
      subtitle: company.description.text.maxLines(1).make(),
    ).pSymmetric(v: 2.h);
  }

  Widget _buildLoading(
    BuildContext context,
  ) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          minTileHeight: 0,
          contentPadding: EdgeInsets.only(left: 20.w, right: 12.w),
          leading: CircleAvatar().shimmer(),
          title: VxSkeleton(
            height: 12.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer().pOnly(right: 8.w, bottom: 4.h),
          subtitle: VxSkeleton(
            height: 8.h,
            borderRadius: BorderRadius.circular(8.r),
          ).shimmer().pOnly(right: 24.w, left: 4.w),
        ).pSymmetric(v: 2.h);
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
          "Companies".text.titleSmall(context).make().pOnly(left: 16.w),
          4.h.heightBox,
          child,
        ],
      ).pOnly(
        top: 12.h,
        bottom: 8.h,
      ),
    ).wFull(context).pSymmetric(h: 8.w);
  }
}
