// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/domain/usecases/agent_usecase.dart';
import 'package:companion/src/features/agent/presentation/views/agent_details_view.dart';
import 'package:companion/src/features/company/presentation/views/company_details_view.dart';
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

  Future<void> deleteAgent(String id) async {
    await ref
        .read(databaseProvider)
        .managers
        .companyToAgentTable
        .filter((f) => f.agentId.id.equals(id))
        .delete();
    await ref.read(agentUseCaseProvider).deleteAgent(id);
    ref.invalidate(companyDetailsProvider);
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
    ref.invalidate(agentDetailsProvider(params.id));
    ref.invalidate(companyDetailsProvider);
  }
}
