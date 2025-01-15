import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/utils/color_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CompanyCard extends ConsumerWidget {
  final CompanyModel company;
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
              color: company.hexColor.colorFromHex().withAlpha(50),
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
                  .make(),
            ),
          ).p8(),
          ListTile(
            leading: Hero(
              tag: "Company-${company.id}",
              child: CircleAvatar(
                backgroundColor: company.hexColor.colorFromHex(),
                child: company.name[0].text.titleLarge(context).make(),
              ).onTap(() {
                context.pushRoute(
                  CompanyDetailsRoute(companyId: company.id),
                );
              }),
            ),
            title: company.name.text.maxLines(1).semiBold.make().onTap(
              () {
                context.pushRoute(
                  CompanyDetailsRoute(companyId: company.id),
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
