import 'package:companion/src/features/company_to_agent/domain/entity/company_to_agent_entity.dart';
import 'package:companion/src/features/company_to_agent/domain/repositories/company_to_agent_repository.dart';

class CompanyToAgentUsecase {
  final CompanyToAgentRepository _repository;

  CompanyToAgentUsecase({
    required CompanyToAgentRepository repository,
  }) : _repository = repository;

  Future<List<CompanyToAgentEntity>> getAllByAgentId(String agentId) {
    return _repository.getAllByAgentId(agentId);
  }

  Future<void> linkCompanyToAgent(String companyId, String agentId) {
    return _repository.linkCompanyToAgent(companyId, agentId);
  }

  Future<void> unlinkCompanyWithAgent(String companyId, String agentId) {
    return _repository.unlinkCompanyToAgent(companyId, agentId);
  }
}
