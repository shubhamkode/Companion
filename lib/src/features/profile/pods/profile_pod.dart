import 'dart:convert';
import 'dart:io';

import 'package:companion/src/features/companies/models/company.dart';
import 'package:companion/src/features/companies/pods/companies_pod.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pods/contact_pod.dart';
import 'package:companion/src/features/profile/models/settings.dart';
import 'package:companion/utils.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'profile_pod.g.dart';

@riverpod
class ProfilePod extends _$ProfilePod {
  @override
  FutureOr<SettingsModel> build() {
    return SettingsModel(
      isDarkModeEnabled: true,
    );
  }

  Future<void> exportData(final Directory filePath) async {
    await Hive.box<Company>("companies").exportTo(filePath.path);
    await Hive.box<Contact>("contacts").exportTo(filePath.path);
    await Hive.box<Pim>("pims").exportTo(filePath.path);
  }

  Future<void> importData(final Directory filePath) async {
    final companiesBox = Hive.box<Company>("companies");

    final contactsBox = Hive.box<Contact>("contacts");
    final pimsBox = Hive.box<Pim>("pims");

    final companiesFile = File("${filePath.path}/${companiesBox.name}.json");
    final pimsFile = File("${filePath.path}/${pimsBox.name}.json");

    final contactsFile = File("${filePath.path}/${contactsBox.name}.json");

    final companiesJson =
        json.decode(await companiesFile.readAsString()) as List<dynamic>;

    final companies = companiesJson.builder((ele) => Company.fromJson(ele));

    await companiesBox.putAll(
      Map.fromIterable(
        companies,
        key: (cmp) => cmp.id,
      ),
    );

    final pimsJson =
        json.decode(await pimsFile.readAsString()) as List<dynamic>;

    final pims = pimsJson.builder((ele) => Pim.fromJson(ele));

    await pimsBox.putAll(Map.fromIterable(pims, key: (pim) => pim.id));

    final contactsJson =
        json.decode(await contactsFile.readAsString()) as List<dynamic>;

    final contacts = contactsJson.map(
      (ele) {
        final List<Pim> pims = ele['pims'].map<Pim>((pimId) {
          // if (pimId != null) {
          return pimsBox.get(pimId) as Pim;
          // }
        }).toList();

        final List<Company> companies = ele['companies'].map<Company>((cmpId) {
          return companiesBox.get(cmpId) as Company;
        }).toList();

        return Contact(
          id: ele['id'],
          color: ele["color"],
          created: ele["created"],
          distributor: ele['distributor'],
          name: ele['name'],
          pims: HiveList<Pim>(
            pimsBox,
            objects: pims,
          ),
          companies: HiveList<Company>(
            companiesBox,
            objects: companies,
          ),
        );
      },
    ).toList();

    await contactsBox.putAll(
      Map.fromIterable(contacts, key: (cnt) => cnt.id),
    );

    ref.invalidate(companiesPodProvider);

    ref.invalidate(contactPodProvider);
  }

  Future<void> clearAllData() async {
    await Hive.box<Company>("companies").clear();
    await Hive.box<Contact>("contacts").clear();
    await Hive.box<Pim>("pims").clear();
    ref.invalidate(contactPodProvider);
    ref.invalidate(companiesPodProvider);
  }
}

