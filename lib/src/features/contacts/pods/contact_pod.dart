import 'package:companion/src/features/companies/models/company.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:cuid2/cuid2.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'contact_pod.g.dart';

@riverpod
class ContactPod extends _$ContactPod {
  @override
  FutureOr<List<Contact>> build() async {
    final box = Hive.box<Contact>("contacts");
    return box.values.sortedByString((contact) => contact.name).toList();
  }

  Future<void> addContact({
    required String name,
    required String distributorName,
    required List<Pim> pims,
    required List<Company> companies,
  }) async {
    final contactBox = Hive.box<Contact>("contacts");
    final companiesBox = Hive.box<Company>("companies");
    final pimsBox = Hive.box<Pim>("pims");

    await pimsBox.putAll(
      Map.fromIterable(
        pims,
        key: (pim) => pim.id,
      ),
    );

    final contact = Contact(
      id: cuid(),
      name: name,
      distributor: distributorName,
      pims: HiveList<Pim>(pimsBox, objects: pims),
      companies: HiveList<Company>(companiesBox, objects: companies),
      color: Vx.getMaterialColor(Vx.randomPrimaryColor).value,
      created: DateTime.now().toString(),
    );

    await contactBox.put(contact.id, contact);
    ref.invalidateSelf();
  }

  Future<void> deleteContact(final Contact contact) async {
    final pims = contact.pims;
    await Hive.box<Pim>("pims").deleteAll(pims.builder((pim) => pim.id));
    await Hive.box<Contact>("contacts").delete(contact.id);
    ref.invalidateSelf();
  }
}
