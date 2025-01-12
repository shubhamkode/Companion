import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/hive/hive_pod.dart';
import 'package:companion/src/utils/abstract_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'company_repository.g.dart';

class CompanyRepository implements Repository<CompanyModel> {
  final Future<CollectionBox<CompanyModel>> _box;

  CompanyRepository(this._box);

  @override
  Future<String> create(CompanyModel obj) async {
    await _box.then((box) async => await box.put(obj.id, obj));
    return obj.id;
  }

  @override
  Future<void> delete(CompanyModel obj) async {
    await _box.then(
      (box) async => await box.delete(obj.id),
    );
  }

  @override
  Future<CompanyModel?> read(String id) async {
    return await _box.then((box) async => await box.get(id));
  }

  @override
  Future<List<CompanyModel>> readAll() async {
    return await _box.then(
      (box) async => (await box.getAllValues())
          .values
          .sortedByString((cmp) => cmp.name)
          .toList(),
    );
  }

  @override
  Future<void> update(String id, CompanyModel updatedObj) async {
    await _box.then(
      (box) async => await box.put(id, updatedObj),
    );
  }

  @override
  Future<void> deleteMultiple(List<String> ids) async {
    await _box.then((box) async => await box.deleteAll(ids));
  }

  @override
  Future<void> insertMultipleIfNotExists(
      List<Map<String, dynamic>> objs) async {
    final companies = objs.builder(CompanyModel.fromJson);

    final box = await _box;

    for (CompanyModel company in companies) {
      if (await box.get(company.id) != null) {
        continue;
      }
      await box.put(company.id, company);
    }
  }
}

@riverpod
Repository<CompanyModel> companyRepository(Ref ref) {
  final collection = ref.watch(hivePodProvider);
  return CompanyRepository(collection.openBox<CompanyModel>("companies"));
}
