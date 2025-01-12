import 'dart:io';

import 'package:companion/src/features/backup/mutatations/mutations.dart';
import 'package:companion/src/features/backup/queries/create_table_query.dart';
import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/pages/company_details_page.dart';
import 'package:companion/src/features/companies/pods/company_pod.dart';
import 'package:companion/src/features/companies/repositories/company_repository.dart';
import 'package:companion/src/features/companies_to_contact/models/comp_to_conc_model.dart';
import 'package:companion/src/features/companies_to_contact/repositories/company_to_contact_repository.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pages/contact_details_page.dart';
import 'package:companion/src/features/contacts/pods/contact_pod.dart';
import 'package:companion/src/features/contacts/repositories/contact_repository.dart';
import 'package:companion/src/features/pims/models/pim_model.dart';
import 'package:companion/src/features/pims/repositories/pim_repository.dart';
import 'package:companion/src/features/settings/models/settings_model.dart';
import 'package:companion/src/features/settings/repositories/settings_repository.dart';
import 'package:companion/src/hive/hive_pod.dart';
import 'package:companion/src/utils/dummy_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:velocity_x/velocity_x.dart';

part 'settings_pod.g.dart';

@riverpod
class SettingsPod extends _$SettingsPod {
  @override
  SettingsModel build() {
    final repo = ref.watch(settingsRepositoryProvider);
    return repo.getSettings() ?? SettingsModel();
  }

  /// Reads the [SettingsRepository] and then,
  /// updates the [state] with the toggled theme.
  Future<void> toggleTheme() async {
    final repo = ref.read(settingsRepositoryProvider);

    await repo.updateSettings(state.copyWith(
      isDarkModeEnabled: !state.isDarkModeEnabled,
    ));

    ref.invalidateSelf();
  }

  /// clears the Companion database
  ///
  /// clears all the tables in the database
  Future<void> clearAllData() async {
    final collection = ref.read(hivePodProvider);
    await collection.transaction(
      () async {
        await (await collection.openBox<CompanyModel>("companies")).clear();
        await (await collection
                .openBox<CompanyToContactModel>("company_to_contact"))
            .clear();
        await (await collection.openBox<ContactModel>("contacts")).clear();
        await (await collection.openBox<PimModel>("pims")).clear();
      },
      boxNames: ['contacts', 'companies', 'pims', 'company_to_contact'],
    );

    ref.invalidate(companyPodProvider);
    ref.invalidate(contactPodProvider);
  }

  /// Insert dummy data in the database
  ///
  /// Only available in [Debug] mode.
  /// It will clear all the data in the database and then inserts the dummy data
  Future<void> refresh() async {
    await clearAllData();

    final companyRepo = ref.read(companyRepositoryProvider);
    await Future.wait(dummyCompanies.map((e) => companyRepo.create(e)));

    final contactRepo = ref.read(contactRepositoryProvider);
    await Future.wait(dummyContacts.map((e) => contactRepo.create(e)));

    final pimRepo = ref.read(pimRepositoryProvider);
    await Future.wait(dummyPims.map((e) => pimRepo.create(e)));

    final companyToContactRepo = ref.read(companyToContactRepositoryProvider);
    await Future.wait(
        dummyCompanyToContact.map((e) => companyToContactRepo.create(e)));

    ref.invalidate(companyPodProvider);
    ref.invalidate(contactPodProvider);
  }

  /// Changes the default backup directory of the app
  Future<void> changeBackupPath() async {
    final repo = ref.read(settingsRepositoryProvider);

    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: "Select Directoy for Backup",
    );
    if (dir == null) {
      return;
    }

    await repo.updateSettings(state.copyWith(backupPath: "$dir/Companion/"));
    ref.invalidateSelf();
  }

  /// Imports the data from the backup SQL [Database]
  Future<void> importBackup() async {
    if (await Permission.manageExternalStorage.request().isGranted == false) {
      throw Exception("Permission Not Granted");
    }
    final backupDir = Directory(state.backupPath);

    /// Check if the directory exists
    if (!backupDir.existsSync()) {
      throw Exception("Backup Doesn't exists");
    }

    final backupSQLFile = backupDir.listSync()[0];

    /// Backup database is assumed to be only file present in the backup Directory
    final backupDb = await openReadOnlyDatabase(backupSQLFile.path);

    if (!backupDb.isOpen) {
      /// Throw Exception if unable to Open Database
      throw Exception("Unable to open Database");
    }

    /// Box Collection
    final collection = ref.read(hivePodProvider);

    final companyBox = await collection.openBox<CompanyModel>('companies');
    final relationBox =
        await collection.openBox<CompanyToContactModel>('company_to_contact');
    final pimBox = await collection.openBox<PimModel>('pims');

    final contactsBox = await collection.openBox<ContactModel>('contacts');

    final contacts = (await contactsBox.getAllValues()).valuesList();

    /// Used for avoid data duplication in the app database
    final contactIds = contacts.builder((cnt) => cnt.id);

    try {
      final rawCompanies = await backupDb.query(
        'company',
      );

      final rawPims = await backupDb.query(
        'pim',
        where:
            'contact_id NOT IN (${List.filled(contactIds.length, '?').join(',')})',
        whereArgs: contactIds,
      );

      final rawRelations = await backupDb.query(
        'company_to_contact',
        where:
            'contact_id NOT IN (${List.filled(contactIds.length, '?').join(',')})',
        whereArgs: contactIds,
      );

      final rawContacts = await backupDb.query(
        'contact',
        where: 'id NOT IN (${List.filled(contactIds.length, '?').join(',')})',
        whereArgs: contactIds,
      );
      final dbContacts = rawContacts.map(ContactModel.fromJson).toList();

      final dbCompanies = rawCompanies.map(CompanyModel.fromJson).toList();
      final dbPims = rawPims.map(PimModel.fromJson).toList();

      final dbRelations =
          rawRelations.map(CompanyToContactModel.fromJson).toList();

      await collection.transaction(
        () async {
          for (var dbCompany in dbCompanies) {
            if (await companyBox.get(dbCompany.id) != null) {
              continue;
            }
            await companyBox.put(dbCompany.id, dbCompany);
          }
          for (var pim in dbPims) {
            if (await pimBox.get(pim.id) != null) {
              continue;
            }
            await pimBox.put(pim.id, pim);
          }
          for (var relation in dbRelations) {
            if (await relationBox.get(relation.id) != null) {
              continue;
            }
            await relationBox.put(relation.id, relation);
          }
          for (var contact in dbContacts) {
            await contactsBox.put(contact.id, contact);
          }
        },
      );

      ref.invalidate(contactPodProvider);
      ref.invalidate(contactDetailsProvider);
      ref.invalidate(companyPodProvider);
      ref.invalidate(companyDetailsProvider);
    } catch (e) {
      throw Exception("Import Failed");
    }
  }

  /// Creates a sql [Database] backup of the app database
  /// and copies it to the backup directory.
  Future<bool> createSQLBackup() async {
    final collection = ref.read(hivePodProvider);

    final tempDir = await getTemporaryDirectory();

    final Database db = await openDatabase(p.join(tempDir.path, getFileName()),
        version: 1, onCreate: (db, version) async {
      for (String createQuery in tableCreateQueries) {
        await db.execute(createQuery);
      }
    });

    final batch = db.batch();

    await collection
        .openBox<ContactModel>("contacts")
        .then((box) => box.getAllValues())
        .then((map) => map.values.toList())
        .then((list) => list.builder((cnt) => cnt.toJson()))
        .then((val) async {
      await insertList(batch, 'contact', val);
    });

    await collection
        .openBox<CompanyModel>("companies")
        .then((box) => box.getAllValues())
        .then((map) => map.values.toList())
        .then((list) => list.builder((cnt) => cnt.toJson()))
        .then((val) async {
      await insertList(batch, 'company', val);
    });

    await collection
        .openBox<PimModel>("pims")
        .then((box) => box.getAllValues())
        .then((map) => map.values.toList())
        .then((list) => list.builder((cnt) => cnt.toJson()))
        .then((val) async {
      await insertList(batch, 'pim', val);
    });

    await collection
        .openBox<CompanyToContactModel>("company_to_contact")
        .then((box) => box.getAllValues())
        .then((map) => map.values.toList())
        .then((list) => list.builder((cnt) => cnt.toJson()))
        .then((val) async {
      await insertList(batch, 'company_to_contact', val);
    });

    await batch.commit(noResult: true);

    if (await Permission.manageExternalStorage.request().isGranted) {
      final backupDirectory = Directory(state.backupPath);
      if (backupDirectory.existsSync()) {
        backupDirectory.deleteSync(recursive: true);
      }
      backupDirectory.createSync();
      File(db.path).copySync(p.join(backupDirectory.path, getFileName()));
    }

    await deleteDatabase(db.path);

    return true;
  }
}

/// Used to get the filename of the backup [Database] file
///
/// ex:- **Backup-2025-01-11T10.10.20.db**
String getFileName() {
  final dt = DateTime.now();
  return "Backup-${dt.year}-${dt.month.padLeft(2, '0')}-${dt.day.padLeft(2, '0')}T${dt.hour.padLeft(2, '0')}.${dt.minute.padLeft(2, '0')}.${dt.second.padLeft(2, '0')}.db";
}
