import 'package:companion/src/features/agent/data/data_sources/local/local_agent_datasource.dart';
import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/domain/repositories/agent_repository.dart';
import 'package:companion/src/features/agent/domain/usecases/agent_usecase.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentRepositoryImpl implements AgentRepository {
  final LocalAgentDataSource _localDataSource;

  AgentRepositoryImpl({
    required LocalAgentDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<List<AgentEntity>> getAllAgents() {
    return _localDataSource
        .findAll()
        .then((agents) => agents.builder(AgentEntity.fromModel));
  }

  @override
  Future<void> createNewAgent(NewAgentParams params) async {
    return await _localDataSource.create(params);
  }

  @override
  Future<void> deleteAgent(String id) {
    return _localDataSource.deleteById(id);
  }
}
