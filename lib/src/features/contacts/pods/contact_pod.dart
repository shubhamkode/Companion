import 'package:companion/src/features/companies/pages/company_details_page.dart';
import 'package:companion/src/features/companies_to_contact/models/comp_to_conc_model.dart';
import 'package:companion/src/features/companies_to_contact/repositories/company_to_contact_repository.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pages/contact_details_page.dart';
import 'package:companion/src/features/contacts/repositories/contact_repository.dart';
import 'package:companion/src/features/pims/models/pim_model.dart';
import 'package:companion/src/features/pims/repositories/pim_repository.dart';
import 'package:companion/src/hive/hive_pod.dart';
import 'package:companion/src/utils/uuid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'contact_pod.g.dart';

@riverpod
class ContactPod extends _$ContactPod {
  @override
  FutureOr<List<ContactModel>> build() async {
    final repo = ref.watch(contactRepositoryProvider);
    return await repo.readAll();
  }

  Future<void> insertContact(final ContactModel contact) async {
    final repo = ref.read(contactRepositoryProvider);
    await repo.create(contact);
    ref.invalidateSelf();
  }

  Future<void> createContact({
    required String id,
    required String name,
    required String distributor,
    required List<String> companyIds,
    required List<PimModel> pims,
  }) async {
    final repo = ref.read(contactRepositoryProvider);
    final pimRepo = ref.read(pimRepositoryProvider);
    final collection = ref.read(hivePodProvider);
    final companyToContactRepository =
        ref.read(companyToContactRepositoryProvider);

    await AsyncValue.guard(
      () async {
        await collection.transaction(() async {
          await Future.wait(pims.map(pimRepo.create));

          await repo.create(
            ContactModel(
              id: id,
              name: name,
              distributor: distributor,
              created: DateTime.now().toString(),
              hexColor: Vx.getMaterialColor(Vx.randomPrimaryColor)
                  .toHex(leadingHashSign: true),
            ),
          );

          Future.wait(
            companyIds.map(
              (cmpId) => companyToContactRepository.create(
                CompanyToContactModel(
                  id: uuid(),
                  companyId: cmpId,
                  contactId: id,
                ),
              ),
            ),
          );
          // await
        }, boxNames: ['pims', 'contacts', 'company_to_contact']).whenComplete(
            () {
          ref.invalidateSelf();
        });
      },
    );
  }

  Future<void> deleteContact(ContactModel contact) async {
    final collection = ref.read(hivePodProvider);

    await collection.transaction(() async {
      final pimBox = await collection.openBox<PimModel>('pims');
      final relationsBox =
          await collection.openBox<CompanyToContactModel>('company_to_contact');

      final contactsBox = await collection.openBox<ContactModel>('contacts');

      final relations = (await relationsBox.getAllValues())
          .valuesList()
          .filter((rel) => rel.contactId == contact.id)
          .toList()
          .builder((rel) => rel.id);

      final contactPims =
          (await pimBox.getAllValues()).valuesList().builder((rel) => rel.id);

      await relationsBox.deleteAll(relations);
      await pimBox.deleteAll(contactPims);
      await contactsBox.delete(contact.id);
    }, boxNames: ['pims', 'company_to_contact', 'contacts']);

    ref.invalidate(contactDetailsProvider);
    ref.invalidate(companyDetailsProvider);
    ref.invalidateSelf();
  }

  Future<void> updateContact(ContactModel contact) async {
    final contactRepository = ref.read(contactRepositoryProvider);
    await contactRepository.update(contact.id, contact);
    ref.invalidateSelf();
  }
}
