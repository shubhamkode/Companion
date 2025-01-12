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
          .slate400
          .makeCentered();
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return CompanyCard(
            company: companies[index],
          );
        },
        separatorBuilder: (_, __) => 4.h.heightBox,
      ),
    );
  }
}
