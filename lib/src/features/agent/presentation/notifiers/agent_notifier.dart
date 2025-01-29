// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/domain/usecases/agent_usecase.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_details_notifier.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_id_provider.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_details_notifier.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agent_notifier.g.dart';

@riverpod
class AgentNotifier extends _$AgentNotifier {
  @override
  Stream<List<AgentEntity>> build() {
    final database = ref.watch(databaseProvider);
    return database.managers.agentTable
        .orderBy((o) => o.name.asc())
        .map(AgentEntity.fromModel)
        .watch();
  }

  Future<void> createNewAgent({
    required NewAgentParams params,
  }) {
    return ref.read(agentUseCaseProvider).createNewAgent(params);
  }

  Future<void> deleteAgent() async {
    final agentId = ref.watch(agentIdProvider);
    await ref
        .read(databaseProvider)
        .managers
        .companyToAgentTable
        .filter((f) => f.agentId.id.equals(agentId))
        .delete();
    await ref.read(agentUseCaseProvider).deleteAgent(agentId);
    ref.invalidate(companyDetailsNotifierProvider);
  }

  updateAgent(UpdateAgentParams params) async {
    await ref
        .read(databaseProvider)
        .managers
        .agentTable
        .filter(
          (f) => f.id.equals(params.id),
        )
        .update(
          (u) => u(
            name: Value.absentIfNull(params.name),
            organization: Value.absentIfNull(params.organization),
            contacts: Value.absentIfNull(params.contacts),
          ),
        );
    ref.invalidate(agentDetailsNotifierProvider);
    ref.invalidate(companyDetailsNotifierProvider);
  }
}
