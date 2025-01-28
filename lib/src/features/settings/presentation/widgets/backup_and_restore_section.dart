import 'dart:io';

import 'package:companion/src/core/database/local_database.dart';
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/agent/presentation/views/agent_details_view.dart';
import 'package:companion/src/features/company/presentation/views/company_details_view.dart';
import 'package:companion/src/features/settings/presentation/notifiers/settings_notifier.dart';
import 'package:companion/src/features/settings/presentation/widgets/settings_button.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:velocity_x/velocity_x.dart';

class BackupAndRestoreSection extends ConsumerWidget {
  const BackupAndRestoreSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupPath = ref.watch(
      settingsNotifierProvider.select((s) => s.backupPath),
    );

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
              subtitle: backupPath.text.make(),
              onTap: () async {
                await ref
                    .read(settingsNotifierProvider.notifier)
                    .changeBackupPath();
              },
            ),
            HStack(
              [
                SettingsButton(
                  icon: Icons.file_download_outlined,
                  text: "Import Data",
                  onTap: () async {
                    try {
                      await _importData(
                        ref,
                        File(p.join(backupPath, 'Companion.sqlite')),
                      );
                      if (context.mounted) {
                        context.showToast(
                          msg: 'Import Success',
                          bgColor: context.colors.primary,
                          textColor: context.colors.onPrimary,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        context.showToast(
                          msg: e.toString(),
                          bgColor: context.colors.errorContainer,
                          textColor: context.colors.onErrorContainer,
                        );
                      }
                    }
                  },
                ).expand(),
                SettingsButton(
                  icon: Icons.share_outlined,
                  text: "Export Data",
                  onTap: () async {
                    try {
                      await _exportData(
                        ref,
                        File(p.join(backupPath, 'Companion.sqlite')),
                      );
                      if (context.mounted) {
                        context.showToast(
                          msg: 'Backup Success',
                          bgColor: context.colors.primary,
                          textColor: context.colors.onPrimary,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        context.showToast(
                          msg: e.toString(),
                          bgColor: context.colors.errorContainer,
                          textColor: context.colors.onErrorContainer,
                        );
                      }
                    }
                  },
                ).expand(),
              ],
              spacing: 8.w,
            ),
            if (kDebugMode)
              SettingsButton(
                icon: Icons.delete_outline_outlined,
                text: "Clear all Data",
                onTap: () async {
                  if (await confirm(
                    context,
                    title: Text("Delete all data").wFull(context),
                    content: Text("All your data will be deleted."),
                    textOK: Text("Proceed"),
                    textCancel: Text("Cancel"),
                  )) {
                    if (context.mounted &&
                        await confirm(
                          context,
                          title: Text("Are you Sure?").wFull(context),
                          content: Text(
                              "You won't be able to recover your data if you don't have a backup?"),
                          textOK: Text("Sure"),
                          textCancel: Text("Cancel"),
                        )) {
                      await ref
                          .read(settingsNotifierProvider.notifier)
                          .clearAllData();
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

  Future<void> _exportData(WidgetRef ref, File backupDB) async {
    final database = ref.read(databaseProvider);

    if (await Permission.manageExternalStorage.request().isGranted) {
      if (backupDB.existsSync()) {
        backupDB.deleteSync();
      }
      backupDB.createSync(recursive: true);
      await database.customStatement(
        "VACUUM INTO ?",
        [backupDB.path],
      );
    }
  }

  Future<void> _importData(
    WidgetRef ref,
    File backupDbUri,
  ) async {
    if (!backupDbUri.existsSync()) {
      throw Exception("Database doesn't exist");
    }

    final backupDB = await openDatabase(
      backupDbUri.path,
      singleInstance: true,
      readOnly: true,
    );

    if (!backupDB.isOpen) {
      throw Exception("Unable to open database");
    }

    final localDB = ref.read(databaseProvider);

    final List<String> existingAgentIds =
        (await localDB.managers.agentTable.get()).builder((b) => b.id);

    final List<String> existingCompanyIds =
        (await localDB.managers.companyTable.get()).builder((b) => b.id);

    final syncableCompanyToAgents = await backupDB.query(
      'company_to_agent_table',
      where:
          "agent_id NOT IN (${List.filled(existingAgentIds.length, '?').join(',')})",
      whereArgs: existingAgentIds,
    );

    final syncableAgents = await backupDB.query(
      'agent_table',
      where:
          "id NOT IN (${List.filled(existingAgentIds.length, '?').join(',')})",
      whereArgs: existingAgentIds,
    );
    final syncableCompanies = await backupDB.query(
      'company_table',
      where:
          "id NOT IN (${List.filled(existingCompanyIds.length, '?').join(',')})",
      whereArgs: existingCompanyIds,
    );

    await localDB.computeWithDatabase(
      computation: (database) async {
        await database.batch((batch) {
          batch.insertAll(
            database.agentTable,
            List.generate(
              syncableAgents.length,
              (index) {
                final Map<String, dynamic> agent = syncableAgents[index];

                return AgentTableCompanion.insert(
                  id: Value(agent['id']),
                  name: agent['name'],
                  organization: agent['organization'],
                  contacts: (agent['contacts'].split(',') as List<String>)
                      .builder((b) => b.replaceAll(RegExp(r'\"'), '')),
                  hexColor: Value(agent['hex_color']),
                  created: Value(
                    DateTime.fromMicrosecondsSinceEpoch(agent['created']),
                  ),
                );
              },
            ),
          );

          batch.insertAll(
            database.companyTable,
            List.generate(
              syncableCompanies.length,
              (index) {
                final Map<String, dynamic> company = syncableCompanies[index];

                return CompanyTableCompanion.insert(
                  id: Value(company['id']),
                  name: company['name'],
                  description: company['name'],
                  hexColor: Value(company['hex_color']),
                  created: Value(
                      DateTime.fromMicrosecondsSinceEpoch(company['created'])),
                );
              },
            ),
          );
          batch.insertAll(
            database.companyToAgentTable,
            List.generate(
              syncableCompanyToAgents.length,
              (index) {
                final Map<String, dynamic> companyToAgent =
                    syncableCompanyToAgents[index];

                return CompanyToAgentTableCompanion.insert(
                  agentId: companyToAgent['agent_id'],
                  companyId: companyToAgent['company_id'],
                );
              },
            ),
          );
        });
      },
      connect: (connection) {
        return AppDatabase(connection);
      },
    );
    await backupDB.close();
    ref.invalidate(agentDetailsProvider);
    ref.invalidate(companyDetailsProvider);
  }
}
