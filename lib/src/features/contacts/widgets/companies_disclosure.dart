import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/utils/color_ext.dart';
import 'package:disclosure/disclosure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CompaniesDisclosure extends StatelessWidget {
  const CompaniesDisclosure({
    super.key,
    required this.companies,
  });

  final List<CompanyModel> companies;

  @override
  Widget build(BuildContext context) {
    return Disclosure(
      header: DisclosureButton(
        wrapper: (action, child) => InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: action,
          child: child,
        ),
        child: DisclosureConsumer(
          builder: (state, child) {
            return ListTile(
              title: HStack(
                [
                  "Companies".text.make(),
                  HStack([
                    companies.length.text.titleMedium(context).make(),
                    8.w.widthBox,
                  ])
                ],
                axisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.spaceBetween,
              ),
              trailing: DisclosureIcon(),
              tileColor: state.opened
                  ? context.colors.secondaryContainer
                  : context.colors.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            );
          },
        ),
      ),
      child: DisclosureView(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: companies.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: companies[index].hexColor.colorFromHex(),
                child: companies[index].name[0].text.titleLarge(context).make(),
              ),
              title: companies[index].name.text.make(),
              subtitle: companies[index].description.text.maxLines(1).make(),
            );
          },
        ),
      ),
    );
  }
}
