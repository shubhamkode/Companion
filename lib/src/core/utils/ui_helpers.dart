import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration getInputDecoration({
  String? hint,
  String? label,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    hintText: hint,
    labelText: label,
  );
}
