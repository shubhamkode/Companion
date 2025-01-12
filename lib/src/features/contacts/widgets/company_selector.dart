import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:velocity_x/velocity_x.dart';

class FormBuilderMultiSelector<T extends Object> extends StatelessWidget {
  final String? name;
  final List<DropdownItem<T>> items;
  final DropdownItemBuilder<T>? itemBuilder;
  final MultiSelectController<T>? controller;

  const FormBuilderMultiSelector({
    super.key,
    this.name,
    required this.items,
    this.itemBuilder,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name ?? "name",
      builder: (FormFieldState<T> field) {
        return MultiDropdown<T>(
          
          fieldDecoration: FieldDecoration(
            backgroundColor: context.colors.surfaceContainer,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          ),
          dropdownDecoration: DropdownDecoration(
            backgroundColor: context.colors.surfaceContainer,
            elevation: 0,
            marginTop: 4.h,
            borderRadius: BorderRadius.circular(8.r),
          ),
          itemBuilder: itemBuilder,
          items: items,
          controller: controller,
          //INFO:- Removed Valdator as a CONTACT may or may not have a company.
          // validator: (val) {
          //   if (controller?.selectedItems.isEmpty == true) {
          //     return "Please select at least one item";
          //   }
          //   return null;
          // },
          chipDecoration: ChipDecoration(
            deleteIcon: Icon(
              Icons.close,
              size: 15,
              color: context.colors.onSecondary,
            ),
            backgroundColor: context.colors.secondary,
            labelStyle: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.onSecondary,
            ),
          ),
        );
      },
    );
  }
}
