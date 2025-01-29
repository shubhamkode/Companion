// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_details_notifier.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_id_provider.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_details_notifier.dart';
import 'package:companion/src/features/company_to_agent/domain/entity/company_to_agent_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_to_agent_notifier.g.dart';

@riverpod
class CompanyToAgentNotifier extends _$CompanyToAgentNotifier {
  @override
  Future<List<CompanyToAgentEntity>> build() async {
    final agentId = ref.watch(agentIdProvider);
    final useCase = ref.watch(companyToAgentUsecaseProvider);
    return useCase.getAllByAgentId(agentId);
  }

  Future<void> addRelation(String companyId) async {
    final agentId = ref.read(agentIdProvider);
    final useCase = ref.read(companyToAgentUsecaseProvider);

    await useCase.linkCompanyToAgent(companyId, agentId);

    ref.invalidate(agentDetailsNotifierProvider);
    ref.invalidate(companyDetailsNotifierProvider);
    ref.invalidateSelf();
  }

  Future<void> removeRelation(String companyId) async {
    final agentId = ref.read(agentIdProvider);
    final useCase = ref.read(companyToAgentUsecaseProvider);

    await useCase.unlinkCompanyWithAgent(companyId, agentId);
    ref.invalidate(agentDetailsNotifierProvider);
    ref.invalidate(companyDetailsNotifierProvider);
    ref.invalidateSelf();
  }
}
