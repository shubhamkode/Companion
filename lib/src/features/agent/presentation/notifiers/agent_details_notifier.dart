// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/presentation/notifiers/agent_id_provider.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'agent_details_notifier.g.dart';

@riverpod
Future<AgentDetailsEntity> agentDetailsNotifier(Ref ref) async {
  final database = ref.watch(databaseProvider);
  final agentId = ref.watch(agentIdProvider);

  final agent = await database.managers.agentTable
      .filter((f) => f.id.equals(agentId))
      .getSingle();

  final linkedCompanyIds = (await database.managers.companyToAgentTable
          .filter((f) => f.agentId.id.equals(agent.id))
          .get())
      .builder((lc) => lc.companyId);

  final linkedCompanies = await database.managers.companyTable
      .filter((f) => f.id.isIn(linkedCompanyIds))
      .orderBy((o) => o.name.asc())
      .get();

  return AgentDetailsEntity(
    agent: AgentEntity.fromModel(agent),
    linkedCompanies: linkedCompanies.builder(CompanyEntity.fromModel),
  );
}

class AgentDetailsEntity {
  final AgentEntity agent;
  final List<CompanyEntity> linkedCompanies;

  AgentDetailsEntity({
    required this.agent,
    required this.linkedCompanies,
  });
}

// final agentDetailsProvider = FutureProvider.family<AgentDetailsEntity, String>(
//   (ref, agentId) async {
//     final database = ref.watch(databaseProvider);

// );
