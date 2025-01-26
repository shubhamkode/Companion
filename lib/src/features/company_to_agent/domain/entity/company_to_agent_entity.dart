import 'package:companion/src/core/database/local_database.dart';

class CompanyToAgentEntity {
  final String companyId;
  final String agentId;

  CompanyToAgentEntity({
    required this.companyId,
    required this.agentId,
  });

  factory CompanyToAgentEntity.fromModel(CompanyToAgentModel model) {
    return CompanyToAgentEntity(
      companyId: model.companyId,
      agentId: model.companyId,
    );
  }
}
