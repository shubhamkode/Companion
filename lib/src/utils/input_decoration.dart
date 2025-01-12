import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration getDecoration({
  String hint = "",
}) =>
    InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      hintText: hint,
      contentPadding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 12.w,
      ),
    );
