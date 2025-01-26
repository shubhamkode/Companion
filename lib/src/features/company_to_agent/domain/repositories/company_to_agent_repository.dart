import 'package:companion/src/features/company_to_agent/domain/entity/company_to_agent_entity.dart';

abstract class CompanyToAgentRepository {
  Future<List<CompanyToAgentEntity>> getAllByAgentId(String agentId);

  Future<void> linkCompanyToAgent(String companyId, String agentId);

  Future<void> unlinkCompanyToAgent(String companyId, String agentId);
}
