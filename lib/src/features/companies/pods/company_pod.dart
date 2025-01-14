import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/pages/company_details_page.dart';
import 'package:companion/src/features/companies/repositories/company_repository.dart';
import 'package:companion/src/features/companies_to_contact/repositories/company_to_contact_repository.dart';
import 'package:companion/src/features/contacts/pages/contact_details_page.dart';
import 'package:companion/src/utils/uuid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'company_pod.g.dart';

@riverpod
class CompanyPod extends _$CompanyPod {
  @override
  FutureOr<List<CompanyModel>> build() async {
    final repo = ref.watch(companyRepositoryProvider);
    return await repo.readAll();
  }

  Future<void> create(
      {required String name, required String description}) async {
    final repo = ref.read(companyRepositoryProvider);

    await AsyncValue.guard(() async {
      await repo.create(
        CompanyModel(
          id: uuid(),
          name: name,
          description: description,
          hexColor: Vx.getMaterialColor(Vx.randomPrimaryColor)
              .toHex(leadingHashSign: true),
        ),
      );
      ref.invalidateSelf();
    });
  }

  Future<void> delete(CompanyModel company) async {
    final companyToContactRepository =
        ref.read(companyToContactRepositoryProvider);

    final repo = ref.read(companyRepositoryProvider);

    await AsyncValue.guard(() async {
      final companyToContact = (await companyToContactRepository.readAll())
          .filter((ele) => ele.companyId == company.id)
          .toList()
          .builder(
            (p) => p.id,
          );

      await Future.wait<void>(
        [
          companyToContactRepository.deleteMultiple(companyToContact),
          repo.delete(company),
        ],
      );
      ref.invalidate(contactDetailsProvider);
      ref.invalidateSelf();
    });
  }

  Future<void> patch(CompanyModel companyModel) async {
    final repo = ref.read(companyRepositoryProvider);
    await AsyncValue.guard(() async {
      await repo.update(companyModel.id, companyModel);
      ref.invalidateSelf();
    });
    ref.invalidate(companyDetailsProvider);
  }
}
