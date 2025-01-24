import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/presentation/widgets/company_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CompaniesList extends StatelessWidget {
  final List<CompanyEntity> companies;
  const CompaniesList({
    super.key,
    required this.companies,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 8.h),
      itemCount: companies.length,
      itemBuilder: (context, index) {
        return CompanyCard(company: companies[index]).pSymmetric(
          h: 12.w,
          v: 2.h,
        );
      },
    );
  }
}
