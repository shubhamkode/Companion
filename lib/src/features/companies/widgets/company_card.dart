import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/features/companies/models/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class CompanyCard extends ConsumerWidget {
  final Company company;
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
              color: Color(company.color).withAlpha(50),
              borderRadius: BorderRadius.circular(6.r),
            ),
            height: 120.h,
          ).p8(),
          ListTile(
            leading: Hero(
              tag: "Company-${company.id}",
              child: CircleAvatar(
                backgroundColor: Color(company.color),
                child: company.name[0].text.titleLarge(context).make(),
              ).onTap(() {
                context.pushRoute(
                  CompanyDetailsRoute(company: company),
                );
              }),
            ),
            title: company.name.text.maxLines(1).semiBold.make().onTap(
              () {
                context.pushRoute(
                  CompanyDetailsRoute(company: company),
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
