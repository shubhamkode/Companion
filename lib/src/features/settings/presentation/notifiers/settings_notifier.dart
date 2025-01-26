// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:companion/src/core/database/local_database.dart';
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/settings/domain/entity/settings_entity.dart';
import 'package:faker/faker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'settings_notifier.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Raw<SettingsEntity> build() {
    final repo = ref.watch(settingsRepositoryProvider);
    return repo.getSettings();
  }

  Future<void> toggleTheme() async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.updateSettings(
      state.copyWith(isDarkModeEnabled: !state.isDarkModeEnabled),
    );
    ref.invalidateSelf();
  }

  Future<void> changeBackupPath() async {
    final repo = ref.read(settingsRepositoryProvider);

    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: "Select new directory for Backup",
    );
    if (dir == null) {
      return;
    }
    await repo.updateSettings(
      state.copyWith(backupPath: p.join(dir, 'Companion')),
    );
    ref.invalidateSelf();
  }

  Future<void> addFakeData() async {
    final database = ref.read(databaseProvider);

    await database.batch((batch) {
      batch.deleteAll(database.agentTable);
      batch.deleteAll(database.companyTable);
      batch.deleteAll(database.companyToAgentTable);
    });

    final dummyAgents = List.generate(
      10,
      (index) {
        return AgentTableCompanion.insert(
          name: faker.person.name(),
          organization: faker.address.city(),
          contacts: List.generate(2, (index) => faker.phoneNumber.ja()),
        );
      },
    );
    final dummyCompanies = List.generate(10, (index) {
      return CompanyTableCompanion.insert(
        name: faker.company.name(),
        description: faker.lorem.sentence(),
      );
    });

    // final dummyAgentIds = dummyAgents.builder((c) => c.id.toString());
    // final dummyCompanyIds = dummyCompanies.builder((c) => c.id.toString());

    // final dummyRelations = List.generate(10, (index) {
    //   return CompanyToAgentTableCompanion.insert(
    //     agentId: dummyAgentIds[index],
    //     companyId: dummyCompanyIds[index],
    //   );
    // });

    await database.batch((batch) {
      batch.insertAll(
        database.agentTable,
        dummyAgents,
      );

      batch.insertAll(
        database.companyTable,
        dummyCompanies,
      );
    });

    final agentIds =
        (await database.managers.agentTable.get()).builder((ag) => ag.id);
    final companyIds =
        (await database.managers.companyTable.get()).builder((cp) => cp.id);

    await database.managers.companyToAgentTable.bulkCreate((o) {
      return List.generate(10, (index) {
        return o(
          agentId: agentIds[index],
          companyId: companyIds[index],
        );
      });
    });
  }

  Future<void> clearAllData() async {
    final database = ref.read(databaseProvider);
    await database.transaction(() async {
      await database.delete(database.agentTable).go();
      await database.delete(database.companyTable).go();
      await database.delete(database.companyToAgentTable).go();
    });
  }
}
