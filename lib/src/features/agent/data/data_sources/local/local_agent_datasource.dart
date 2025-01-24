import 'package:companion/src/core/database/local_database.dart';
import 'package:companion/src/features/agent/domain/usecases/agent_usecase.dart';

abstract class LocalAgentDataSource {
  Future<List<AgentModel>> findAll();

  Future<void> create(NewAgentParams params);

  Future<void> deleteById(String id);
}

class LocalAgentDataSourceImpl implements LocalAgentDataSource {
  final AppDatabase _database;

  LocalAgentDataSourceImpl({
    required AppDatabase database,
  }) : _database = database;

  @override
  Future<List<AgentModel>> findAll() {
    return _database.managers.agentTable.orderBy((o) => o.name.asc()).get();
  }

  @override
  Future<void> create(NewAgentParams params) {
    return _database.managers.agentTable.create(
      (m) => m(
        name: params.name,
        organization: params.organization,
        contacts: params.contacts,
      ),
    );
  }

  @override
  Future<void> deleteById(String id) {
    return _database.managers.agentTable
        .filter((f) => f.id.equals(id))
        .delete();
  }
}
