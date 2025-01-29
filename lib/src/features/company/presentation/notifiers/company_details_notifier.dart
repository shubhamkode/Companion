// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_id_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'company_details_notifier.g.dart';

@riverpod
Future<CompanyDetailsEntity> companyDetailsNotifier(Ref ref) async {
  final database = ref.watch(databaseProvider);
  final companyId = ref.watch(companyIdProvider);

  final company = await database.managers.companyTable
      .filter((f) => f.id.equals(companyId))
      .getSingle();

  final relatedAgentIds = (await database.managers.companyToAgentTable
          .filter((f) => f.companyId.id.equals(companyId))
          .get())
      .builder((m) => m.agentId);

  final relatedAgents = await database.managers.agentTable
      .filter((f) => f.id.isIn(relatedAgentIds))
      .orderBy((o) => o.created.desc())
      .get();

  return CompanyDetailsEntity(
    company: CompanyEntity.fromModel(company),
    relatedAgents: relatedAgents.builder(AgentEntity.fromModel),
  );
}

class CompanyDetailsEntity {
  final CompanyEntity company;
  final List<AgentEntity> relatedAgents;

  CompanyDetailsEntity({
    required this.company,
    required this.relatedAgents,
  });
}
