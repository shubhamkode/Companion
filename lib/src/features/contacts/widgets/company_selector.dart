import 'package:companion/src/features/companies/models/company.dart';
import 'package:companion/src/features/companies/pods/companies_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:velocity_x/velocity_x.dart';

class CompanySelector extends ConsumerWidget {
  final MultiSelectController<Company> controller;
  const CompanySelector({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesProvider = ref.watch(companiesPodProvider);

    return companiesProvider.maybeWhen(
      orElse: () => const CircularProgressIndicator(),
      data: (companies) {
        final List<DropdownItem<Company>> items = companies.builder(
          (cmp) => DropdownItem(
            label: cmp.name,
            value: cmp,
          ),
        );

        return MultiDropdown<Company>(
          controller: controller,
          items: items,
          validator: (selectedOptions) {
            if (selectedOptions!.isEmpty) {
              return "Atleast one company should be selected";
            }
            return null;
          },
          fieldDecoration: FieldDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          dropdownDecoration: DropdownDecoration(
            backgroundColor: context.colors.surfaceContainer,
            elevation: 0,
            marginTop: 4.h,
            borderRadius: BorderRadius.circular(8.r),
          ),
          itemBuilder: (item, index, onTap) {
            final company = item.value;

            return CheckboxListTile(
              title: company.name.text.make(),
              value: controller.selectedItems.contains(item),
              onChanged: (val) {
                onTap();
              },
            );
          },
        );
      },
    );
  }
}


            // footer: OutlinedButton(
            //   style: OutlinedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(4.r),
            //     ),
            //   ),
            //   onPressed: () {
            //     context.pushRoute(NewCompanyRoute());
            //   },
            //   child: "New Company".text.make(),
            // ).pSymmetric(h: 8.w, v: 4.h),