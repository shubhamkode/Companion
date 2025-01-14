import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/widgets/company_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CompaniesList extends StatelessWidget {
  final List<CompanyModel> companies;
  final RefreshCallback onRefresh;
  const CompaniesList({
    super.key,
    required this.companies,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (companies.isEmpty) {
      return "No Companies Found..."
          .text
          .bodyLarge(context)
          .color(context.colors.onSurface.withAlpha(200))
          .makeCentered();
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 12.h),
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return CompanyCard(
            company: companies[index],
          );
        },
        separatorBuilder: (_, __) => 8.h.heightBox,
      ),
    );
  }
}
