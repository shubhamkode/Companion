import 'package:companion/src/utils/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

class BasicDetailsSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController distributorController;
  final bool? autoFocus;

  const BasicDetailsSection({
    super.key,
    required this.nameController,
    required this.distributorController,
    this.autoFocus,
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
          textCapitalization: TextCapitalization.words,
          autofocus: autoFocus == true,
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
          textCapitalization: TextCapitalization.words,
        ),
      ],
      spacing: 8.h,
    );
  }
}
