import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:companion/src/features/companies_to_contact/models/comp_to_conc_model.dart';
import 'package:companion/src/hive/hive_pod.dart';
import 'package:companion/src/utils/abstract_repository.dart';

part 'company_to_contact_repository.g.dart';

class CompanyToContactRepository implements Repository<CompanyToContactModel> {
  final Future<CollectionBox<CompanyToContactModel>> _box;

  CompanyToContactRepository(this._box);

  @override
  Future<String> create(CompanyToContactModel obj) async {
    await _box.then((box) => box.put(obj.id, obj));
    return obj.id;
  }

  @override
  Future<void> delete(CompanyToContactModel obj) {
    return _box.then((box) => box.delete(obj.id));
  }

  @override
  Future<void> deleteMultiple(List<String> ids) {
    return _box.then((box) => box.deleteAll(ids));
  }

  @override
  Future<CompanyToContactModel?> read(String id) {
    return _box.then((box) => box.get(id));
  }

  @override
  Future<List<CompanyToContactModel>> readAll() {
    return _box.then((box) async => (await box.getAllValues()).values.toList());
  }

  @override
  Future<void> update(String id, CompanyToContactModel updatedObj) {
    return _box.then((box) => box.put(id, updatedObj));
  }

  @override
  Future<void> insertMultipleIfNotExists(
      List<Map<String, dynamic>> objs) async {
    final companyToContact = objs.builder(CompanyToContactModel.fromJson);

    final box = await _box;

    for (CompanyToContactModel relation in companyToContact) {
      if (await box.get(relation.id) != null) {
        continue;
      }
      await box.put(relation.id, relation);
    }
  }
}

@riverpod
Repository<CompanyToContactModel> companyToContactRepository(Ref ref) {
  final collection = ref.read(hivePodProvider);
  return CompanyToContactRepository(
    collection.openBox<CompanyToContactModel>("company_to_contact"),
  );
}
