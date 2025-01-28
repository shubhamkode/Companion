import 'package:companion/src/features/settings/presentation/notifiers/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class BasicSettingsSection extends ConsumerWidget {
  const BasicSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkModeEnabled = ref.watch(
      settingsNotifierProvider.select((s) => s.isDarkModeEnabled),
    );

    return VStack(
      [
        "Basic Settings".text.labelSmall(context).make(),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
          title: "Enable Dark Mode".text.make(),
          trailing: Switch(
            value: isDarkModeEnabled,
            onChanged: (val) async {
              await ref.read(settingsNotifierProvider.notifier).toggleTheme();
            },
          ),
        ),
      ],
      spacing: 4.h,
    );
  }
}
