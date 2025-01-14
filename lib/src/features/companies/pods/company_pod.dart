import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/pages/company_details_page.dart';
import 'package:companion/src/features/companies/repositories/company_repository.dart';
import 'package:companion/src/features/companies_to_contact/repositories/company_to_contact_repository.dart';
import 'package:companion/src/features/contacts/pages/contact_details_page.dart';
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

  Future<void> create(CompanyModel company) async {
    await ref.read(companyRepositoryProvider).create(company);
    ref.invalidateSelf();
  }

  Future<void> patch(CompanyModel updatedCompany) async {
    await ref
        .read(companyRepositoryProvider)
        .update(updatedCompany.id, updatedCompany);
    ref.invalidateSelf();
    ref.invalidate(companyDetailsProvider);
  }

  Future<void> delete(CompanyModel company) async {
    final companyToContactRepository =
        ref.read(companyToContactRepositoryProvider);

    final repo = ref.read(companyRepositoryProvider);

    await AsyncValue.guard(() async {
      final relations = (await companyToContactRepository.readAll())
          .filter((ele) => ele.companyId == company.id)
          .toList()
          .builder((p) => p.id);

      await Future.wait<void>([
        companyToContactRepository.deleteMultiple(relations),
        repo.delete(company),
      ]);
      ref.invalidate(contactDetailsProvider);
      ref.invalidateSelf();
    });
  }
}
