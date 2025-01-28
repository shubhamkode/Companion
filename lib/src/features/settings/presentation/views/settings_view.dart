import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/database/local_database.dart';
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/settings/presentation/notifiers/settings_notifier.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
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
    final settings = ref.watch(settingsNotifierProvider);

    final bool isDarkModeEnabled = ref.watch(settingsNotifierProvider
        .select((settings) => settings.isDarkModeEnabled));

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
              await ref.read(settingsNotifierProvider.notifier).toggleTheme();
            },
          ),
        ),
      ],
      spacing: 4.h,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              subtitle: backupPath?.text.make(),
              onTap: () async {
                await ref
                    .read(settingsNotifierProvider.notifier)
                    .changeBackupPath();
              },
            ),
            HStack(
              [
                ActionButton(
                  icon: Icons.file_download_outlined,
                  label: "Import Data".text.make(),
                  onPressed: () async {
                    try {
                      final backupDatabase = File(
                        p.join(ref.read(settingsNotifierProvider).backupPath,
                            'Companion.sqlite'),
                      );

                      await importData(
                        backupDatabase,
                        ref,
                      );

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
                      final database = ref.read(databaseProvider);

                      final backupDir = Directory(
                          ref.read(settingsNotifierProvider).backupPath)
                        ..createSync(
                          recursive: true,
                        );

                      final backupFile =
                          File(p.join(backupDir.path, 'Companion.sqlite'));

                      if (await Permission.manageExternalStorage
                          .request()
                          .isGranted) {
                        if (backupFile.existsSync()) {
                          backupFile.deleteSync();
                        }
                        await database.customStatement(
                            "VACUUM INTO ?", [backupFile.path]);
                      }
                      if (mounted) {
                        context.showToast(
                          msg: 'Backup Success',
                          bgColor: context.colors.primary,
                          textColor: context.colors.onPrimary,
                        );
                      }
                    }).expand(),
              ],
              spacing: 8.w,
            ),
            // 4.h.heightBox,
            if (kDebugMode)
              ActionButton(
                icon: Icons.delete_outline_outlined,
                label: "Clear all Data".text.make(),
                onPressed: () async {
                  if (await confirm(context,
                      title: Text("Delete all Data").wFull(context),
                      content: Text("All your data will be deleted."),
                      textOK: Text("Proceed"),
                      textCancel: Text("Cancel"))) {
                    if (await confirm(context..mounted,
                        title: Text("Are your sure?"),
                        content: Text(
                            "You won't be able to recover your data if you don't have a backup?"),
                        textOK: Text("Sure"),
                        textCancel: Text("Cancel"))) {
                      await ref
                          .read(settingsNotifierProvider.notifier)
                          .clearAllData();
                      // await ref.read(settingsPodProvider.notifier).clearAllData();
                    }
                  }
                },
              ).wFull(context),
          ],
          spacing: 2.h,
        ),
      ],
      spacing: 4.h,
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

Future<void> importData(File backupDb, WidgetRef ref) async {
  if (!backupDb.existsSync()) {
    throw Exception("Database doesn't exist");
  }

  final backup = await openDatabase(
    backupDb.path,
    singleInstance: true,
    onOpen: (db) async {
      await db.rawQuery("PRAGMA journal_mode=memory");
    },
  );

  if (!backup.isOpen) {
    throw Exception("Unable to open Database");
  }

  final database = ref.read(databaseProvider);

  final existingAgentIds =
      (await database.managers.agentTable.get()).builder((b) => b.id);
  final existingCompanyIds =
      (await database.managers.companyTable.get()).builder((b) => b.id);

  final toBackupCompanyToAgents = await backup.query(
    'company_to_agent_table',
    where:
        "agent_id NOT IN (${List.filled(existingAgentIds.length, '?').join(',')})",
    whereArgs: existingAgentIds,
  );

  final toBackupAgents = await backup.query(
    'agent_table',
    where: "id NOT IN (${List.filled(existingAgentIds.length, '?').join(',')})",
    whereArgs: existingAgentIds,
  );

  final toBackupCompanies = await backup.query(
    'company_table',
    where:
        "id NOT IN (${List.filled(existingCompanyIds.length, '?').join(',')})",
    whereArgs: existingCompanyIds,
  );

  await database.batch((batch) {
    batch.insertAll(
      database.agentTable,
      List.generate(
        toBackupAgents.length,
        (index) {
          final Map<String, dynamic> agent = toBackupAgents[index];

          return AgentTableCompanion.insert(
            id: Value(agent['id']),
            name: agent['name'],
            organization: agent['organization'],
            contacts: (agent['contacts'].split(',') as List<String>)
                .builder((b) => b.replaceAll(RegExp(r'\"'), '')),
            hexColor: Value(agent['hex_color']),
            created:
                Value(DateTime.fromMicrosecondsSinceEpoch(agent['created'])),
          );
        },
      ),
    );

    batch.insertAll(
      database.companyTable,
      List.generate(
        toBackupCompanies.length,
        (index) {
          final Map<String, dynamic> company = toBackupCompanies[index];

          return CompanyTableCompanion.insert(
            id: Value(company['id']),
            name: company['name'],
            description: company['name'],
            hexColor: Value(company['hex_color']),
            created:
                Value(DateTime.fromMicrosecondsSinceEpoch(company['created'])),
          );
        },
      ),
    );
    batch.insertAll(
      database.companyToAgentTable,
      List.generate(
        toBackupCompanyToAgents.length,
        (index) {
          final Map<String, dynamic> companyToAgent =
              toBackupCompanyToAgents[index];

          return CompanyToAgentTableCompanion.insert(
            agentId: companyToAgent['agent_id'],
            companyId: companyToAgent['company_id'],
          );
        },
      ),
    );
  });
  await backup.close();
  ref.invalidate(databaseProvider);
}
