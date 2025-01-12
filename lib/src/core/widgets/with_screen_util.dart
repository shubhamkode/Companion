import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class WithScreenUtil extends StatelessWidget {
  final Widget child;
  const WithScreenUtil({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      ensureScreenSize: true,
      child: child,
    );
  }
}
