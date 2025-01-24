// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/agent/presentation/views/agent_details_view.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/domain/usecases/company_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_notifier.g.dart';

@riverpod
class CompanyNotifier extends _$CompanyNotifier {
  @override
  Stream<List<CompanyEntity>> build() {
    final database = ref.watch(databaseProvider);
    return database.managers.companyTable
        .orderBy((o) => o.name.asc())
        .map(CompanyEntity.fromModel)
        .watch();
  }

  Future<void> createCompany(NewCompanyParams params) {
    return ref.read(companyUseCaseProvider).newCompany(params);
  }

  Future<void> deleteCompany(String id) async {
    await ref
        .read(databaseProvider)
        .managers
        .companyToAgentTable
        .filter((f) => f.companyId.id.equals(id))
        .delete();
    await ref.read(companyUseCaseProvider).deleteCompany(id);

    //remove
    ref.invalidate(agentDetailsProvider);
  }
}
