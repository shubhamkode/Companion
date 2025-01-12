import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanionTextField extends StatelessWidget {
  const CompanionTextField({
    super.key,
    this.controller,
    this.textInputAction,
    this.hint,
    this.validator,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? hint;
  final String? Function(String?)? validator;
  final Null Function(String? val)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 12.w,
        ),
        hintText: hint,
      ),
      textInputAction: textInputAction,
      controller: controller,
      validator: validator,
    );
  }
}
