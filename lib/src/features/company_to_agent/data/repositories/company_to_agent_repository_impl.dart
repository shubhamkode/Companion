import 'package:companion/src/features/company_to_agent/data/data_sources/local/local_company_to_agent_datasource.dart';
import 'package:companion/src/features/company_to_agent/domain/entity/company_to_agent_entity.dart';
import 'package:companion/src/features/company_to_agent/domain/repositories/company_to_agent_repository.dart';
import 'package:velocity_x/velocity_x.dart';

class CompanyToAgentRepositoryImpl implements CompanyToAgentRepository {
  final LocalCompanyToAgentDataSource _dataSource;

  CompanyToAgentRepositoryImpl({
    required LocalCompanyToAgentDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<List<CompanyToAgentEntity>> getAllByAgentId(String agentId) async {
    return (await _dataSource.getAllByAgentId(agentId))
        .builder(CompanyToAgentEntity.fromModel);
  }

  @override
  Future<void> linkCompanyToAgent(String companyId, String agentId) {
    return _dataSource.create(companyId, agentId);
  }

  @override
  Future<void> unlinkCompanyToAgent(String companyId, String agentId) {
    return _dataSource.delete(companyId, agentId);
  }
}
