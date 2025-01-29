// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_details_notifier.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/domain/usecases/company_usecase.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_details_notifier.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_id_provider.dart';
import 'package:drift/drift.dart';
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

  Future<void> deleteCompany() async {
    final companyId = ref.watch(companyIdProvider);
    await ref
        .read(databaseProvider)
        .managers
        .companyToAgentTable
        .filter((f) => f.companyId.id.equals(companyId))
        .delete();
    await ref.read(companyUseCaseProvider).deleteCompany(companyId);

    ref.invalidate(agentDetailsNotifierProvider);
  }

  Future<void> updateCompany(UpdateCompanyParams params) async {
    await ref
        .read(databaseProvider)
        .managers
        .companyTable
        .filter((f) => f.id.equals(params.id))
        .update(
          (f) => f(
            name: Value(params.name),
            description: Value(params.description),
          ),
        );

    ref.invalidate(companyDetailsNotifierProvider);
    ref.invalidate(agentDetailsNotifierProvider);
  }
}
