import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/settings/presentation/notifiers/settings_notifier.dart';
import 'package:companion/src/features/settings/presentation/widgets/backup_and_restore_section.dart';
import 'package:companion/src/features/settings/presentation/widgets/basic_settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: "Settings".text.make(),
    );
  }

  _buildBody() {
    return Consumer(
      builder: (context, ref, child) {
        final bool isDarkModeEnabled = ref.watch(
          settingsNotifierProvider
              .select((settings) => settings.isDarkModeEnabled),
        );
        return AnnotatedRegion(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: isDarkModeEnabled
                ? ThemeData.dark().colorScheme.surfaceContainer
                : context.colors.surfaceContainer,
          ),
          child: child!,
        );
      },
      child: SingleChildScrollView(
        child: VStack(
          [
            BasicSettingsSection(),
            BackupAndRestoreSection(),
          ],
          spacing: 12.h,
        ).pSymmetric(v: 16.h, h: 16.w),
      ),
    );
  }
}
