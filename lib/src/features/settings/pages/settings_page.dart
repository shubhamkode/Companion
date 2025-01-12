import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/settings/pods/settings_pod.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: "Settings".text.make(),
      titleSpacing: 0,
    );
  }

  _buildBody() {
    final settings = ref.watch(settingsPodProvider);

    final bool isDarkModeEnabled = ref.watch(
        settingsPodProvider.select((settings) => settings.isDarkModeEnabled));

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: isDarkModeEnabled
            ? ThemeData.dark().colorScheme.surfaceContainer
            : context.colors.surfaceContainer,
      ),
      child: SingleChildScrollView(
        child: VStack(
          [
            _buildBasicSettings(
              isDarkModeEnabled: settings.isDarkModeEnabled,
            ),
            _buildBackupAndRestore(
              backupPath: settings.backupPath,
            ),
          ],
          spacing: 12.h,
        ).pSymmetric(v: 16.h, h: 16.w),
      ),
    );
  }

  Widget _buildBasicSettings({
    required bool isDarkModeEnabled,
  }) {
    return VStack(
      [
        "Basic Settings".text.labelSmall(context).make(),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
          title: "Enable Dark Mode".text.make(),
          trailing: Switch(
            value: isDarkModeEnabled,
            onChanged: (val) async {
              await ref.read(settingsPodProvider.notifier).toggleTheme();
            },
          ),
        ),
      ],
      spacing: 8.h,
    );
  }

  Widget _buildBackupAndRestore({
    String? backupPath,
  }) {
    return VStack(
      [
        "Backup and Restore".text.labelSmall(context).make(),
        VStack(
          [
            ListTile(
              leading: Icon(Icons.save_outlined),
              title: "Backup Dir".text.make(),
              subtitle: backupPath?.text.make(),
              onTap: () async {
                await ref.read(settingsPodProvider.notifier).changeBackupPath();
              },
            ),
            HStack(
              [
                ActionButton(
                  icon: Icons.file_download_outlined,
                  label: "Import Data".text.make(),
                  onPressed: () async {
                    try {
                      await ref
                          .read(settingsPodProvider.notifier)
                          .importBackup();
                      context
                        ..mounted
                        ..showToast(
                          msg: "Import Success",
                          bgColor: Theme.of(context..mounted)
                              .colorScheme
                              .primaryContainer,
                          textColor: Theme.of(context..mounted)
                              .colorScheme
                              .onPrimaryContainer,
                        );
                    } catch (e) {
                      context
                        ..mounted
                        ..showToast(
                          msg: e.toString(),
                          bgColor: Theme.of(context..mounted)
                              .colorScheme
                              .errorContainer,
                          textColor: Theme.of(context..mounted)
                              .colorScheme
                              .onErrorContainer,
                        );
                    }
                  },
                ).expand(),
                ActionButton(
                    icon: Icons.share_outlined,
                    label: "Export Data".text.make(),
                    onPressed: () async {
                      try {
                        if (await ref
                            .read(settingsPodProvider.notifier)
                            .createSQLBackup()) {
                          context
                            ..mounted
                            ..showToast(
                              msg: "Backup Success",
                              bgColor: Theme.of(context..mounted)
                                  .colorScheme
                                  .primaryContainer,
                              textColor: Theme.of(context..mounted)
                                  .colorScheme
                                  .onPrimaryContainer,
                            );
                        }
                      } catch (e) {
                        context
                          ..mounted
                          ..showToast(
                            msg: e.toString(),
                            bgColor: Theme.of(context..mounted)
                                .colorScheme
                                .errorContainer,
                            textColor: Theme.of(context..mounted)
                                .colorScheme
                                .onErrorContainer,
                          );
                      }
                    }).expand(),
              ],
              spacing: 12.w,
            ),
            // 4.h.heightBox,
            ActionButton(
              icon: Icons.delete_outline_outlined,
              label: "Clear all Data".text.make(),
              onPressed: () async {
                if (await confirm(context,
                    title: Text("Delete all Data").wFull(context),
                    content: Text("All your data will be deleted"),
                    textOK: Text("Sure"),
                    textCancel: Text("Cancel"))) {
                  if (await confirm(context..mounted,
                      title: Text("Are your sure?"),
                      content: Text(
                          "You won't be able to recover your data if you don't have a backup?"),
                      textOK: Text("Proceed"),
                      textCancel: Text("Cancel"))) {
                    await ref.read(settingsPodProvider.notifier).clearAllData();
                  }
                }
              },
            ).wFull(context),
          ],
          spacing: 4.h,
        ),
      ],
      spacing: 8.h,
    );
  }
}

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget label;
  final IconData? icon;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      icon: Icon(icon),
      onPressed: onPressed,
      label: label,
    );
  }
}
