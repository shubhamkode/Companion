import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/domain/usecases/agent_usecase.dart';

abstract class AgentRepository {
  Future<List<AgentEntity>> getAllAgents();

  Future<void> createNewAgent(NewAgentParams params);

  Future<void> deleteAgent(String id);
}
