import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/hive/hive_pod.dart';
import 'package:companion/src/utils/abstract_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'contact_repository.g.dart';

class ContactRepository implements Repository<ContactModel> {
  final Future<CollectionBox<ContactModel>> _box;

  ContactRepository(this._box);

  @override
  Future<String> create(ContactModel obj) async {
    await _box.then((box) async => await box.put(obj.id, obj));
    return obj.id;
  }

  @override
  Future<void> delete(ContactModel obj) async {
    await _box.then((box) async => await box.delete(obj.id));
  }

  @override
  Future<ContactModel?> read(String id) async {
    return await _box.then(
      (box) async => await box.get(id),
    );
  }

  @override
  Future<List<ContactModel>> readAll() async {
    return await _box.then((box) async => (await box.getAllValues())
        .values
        .sortedByString((cnt) => cnt.name)
        .toList());
  }

  @override
  Future<void> update(String id, ContactModel updatedObj) async {
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
    final contacts = objs.builder(ContactModel.fromJson);

    final box = await _box;

    for (ContactModel contact in contacts) {
      if (await box.get(contact.id) != null) {
        continue;
      }
      await box.put(contact.id, contact);
    }
  }
}

@riverpod
Repository<ContactModel> contactRepository(Ref ref) {
  final collection = ref.watch(hivePodProvider);
  return ContactRepository(
    collection.openBox<ContactModel>("contacts"),
  );
}
