import 'package:companion/src/features/pims/models/pim_model.dart';
import 'package:companion/src/hive/hive_pod.dart';
import 'package:companion/src/utils/abstract_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'pim_repository.g.dart';

class PimRepository implements Repository<PimModel> {
  final Future<CollectionBox<PimModel>> _box;

  PimRepository(this._box);

  @override
  Future<String> create(PimModel obj) async {
    final box = await _box;
    await box.put(obj.id, obj);
    return obj.id;
  }

  @override
  Future<void> delete(PimModel obj) async {
    final box = await _box;
    await box.delete(obj.id);
  }

  @override
  Future<PimModel?> read(String id) async {
    return (await _box).get(id);
  }

  @override
  Future<List<PimModel>> readAll() async {
    final box = await _box;
    final values = await box.getAllValues();
    return values.values.toList().sortedBy(
          (a, b) => DateTime.parse(a.created).compareTo(
            DateTime.parse(b.created),
          ),
        );
  }

  @override
  Future<void> update(String id, PimModel updatedObj) async {
    final box = await _box;
    await box.put(
      id,
      updatedObj,
    );
  }

  @override
  Future<void> deleteMultiple(List<String> ids) async {
    await _box.then((box) async => await box.deleteAll(ids));
  }

  @override
  Future<void> insertMultipleIfNotExists(
      List<Map<String, dynamic>> objs) async {
    final pims = objs.builder(PimModel.fromJson);
    final box = await _box;

    for (PimModel pim in pims) {
      if (await box.get(pim.id) != null) {
        continue;
      }
      await box.put(pim.id, pim);
    }
  }
}

@riverpod
Repository<PimModel> pimRepository(Ref ref) {
  final collection = ref.watch(hivePodProvider);
  return PimRepository(
    collection.openBox<PimModel>("pims"),
  );
}
