import 'package:companion/src/utils/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

class BasicDetailsSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController distributorController;

  const BasicDetailsSection({
    super.key,
    required this.nameController,
    required this.distributorController,
  });

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        FormBuilderTextField(
          name: "name",
          decoration: getDecoration(hint: "Name"),
          controller: nameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose(
            [
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(2),
            ],
          ),
        ),
        FormBuilderTextField(
          name: "distributor",
          decoration: getDecoration(hint: "Distributor"),
          controller: distributorController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose(
            [
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(2),
            ],
          ),
        ),
      ],
      spacing: 8.h,
    );
  }
}
