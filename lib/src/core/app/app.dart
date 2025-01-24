import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/core/theme/app_theme.dart';
import 'package:companion/src/features/settings/presentation/notifiers/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanionApp extends ConsumerWidget {
  const CompanionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    final isDarkModeEnabled = ref.watch(settingsNotifierProvider.select(
      (settings) => settings.isDarkModeEnabled,
    ));

    return WithScreenUtil(
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: isDarkModeEnabled
              ? AppTheme.light.colorScheme.secondaryContainer
              : AppTheme.dark.colorScheme.secondaryContainer,
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          routerConfig: router.config(),
        ),
      ),
    );
  }
}

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
