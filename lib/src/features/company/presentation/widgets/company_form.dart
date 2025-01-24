import 'package:companion/src/core/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CompanyForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController, descriptionController;
  const CompanyForm({
    super.key,
    required this.formKey,
    required this.descriptionController,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: VStack(
        [
          TextFormField(
            autofocus: true,
            decoration: getInputDecoration(
              hint: 'Company Name',
              label: 'Name',
            ),
            textCapitalization: TextCapitalization.words,
            controller: nameController,
          ),
          TextFormField(
            decoration: getInputDecoration(
              hint: 'Description',
            ),
            controller: descriptionController,
            maxLines: 5,
          ),
        ],
        spacing: 12.h,
      ).pSymmetric(h: 16.w, v: 8.h),
    );
  }
}
