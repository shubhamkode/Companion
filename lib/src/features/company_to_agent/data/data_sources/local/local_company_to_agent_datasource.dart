import 'package:companion/src/core/database/local_database.dart';
import 'package:drift/drift.dart';

abstract class LocalCompanyToAgentDataSource {
  Future<List<CompanyToAgentModel>> getAllByAgentId(String agentId);

  Future<void> create(String companyId, String agentId);

  Future<void> delete(String companyId, String agentId);
}

class LocalCompanyToAgentDataSourceImpl
    implements LocalCompanyToAgentDataSource {
  final AppDatabase database;

  LocalCompanyToAgentDataSourceImpl({
    required this.database,
  });

  @override
  Future<List<CompanyToAgentModel>> getAllByAgentId(String agentId) {
    return database.managers.companyToAgentTable
        .filter((f) => f.agentId.id.equals(agentId))
        .get();
  }

  @override
  Future<void> create(String companyId, String agentId) {
    return database.managers.companyToAgentTable.create((r) => r(
          companyId: companyId,
          agentId: agentId,
        ));
  }

  @override
  Future<void> delete(String companyId, String agentId) {
    return database.managers.companyToAgentTable
        .filter((f) =>
            f.agentId.id.equals(agentId) & f.companyId.id.equals(companyId))
        .delete();
  }
}
