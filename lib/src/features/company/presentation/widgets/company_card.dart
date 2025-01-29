import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CompanyCard extends ConsumerWidget {
  final CompanyEntity company;
  const CompanyCard({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: VStack(
        [
          Container(
            decoration: BoxDecoration(
              color: company.hexColor.withAlpha(50),
              borderRadius: BorderRadius.circular(6.r),
            ),
            height: 120.h,
            child: Center(
              child: (company.name.split(" ")[0])
                  .replaceFirst(",", "")
                  .text
                  .displayMedium(context)
                  .color(context.colors.onSurface.withAlpha(150))
                  .center
                  .make()
                  .pSymmetric(h: 4.w),
            ),
          ).p8(),
          ListTile(
            leading: Hero(
              tag: "Company-${company.id}",
              child: CircleAvatar(
                backgroundColor: company.hexColor,
                child: company.name[0].text
                    .titleLarge(context)
                    .color(context.colors.surface)
                    .make(),
              ).onTap(() {
                ref
                    .read(companyIdProvider.notifier)
                    .update((state) => company.id);
                context.pushRoute(
                  CompanyDetailsRoute(),
                );
              }),
            ),
            title: company.name.text.maxLines(1).semiBold.make().onTap(
              () {
                ref
                    .read(companyIdProvider.notifier)
                    .update((state) => company.id);
                context.pushRoute(
                  CompanyDetailsRoute(),
                );
              },
            ),
            subtitle:
                company.description.text.maxLines(1).bodyMedium(context).make(),
          ),
        ],
      ),
    );
  }
}
