import 'package:companion/src/features/agent/domain/entity/agent_entity.dart';
import 'package:companion/src/features/agent/domain/repositories/agent_repository.dart';

class AgentUsecase {
  final AgentRepository _repository;

  AgentUsecase({
    required AgentRepository repository,
  }) : _repository = repository;

  Future<List<AgentEntity>> getAllAgents() {
    return _repository.getAllAgents();
  }

  createNewAgent(NewAgentParams params) {
    return _repository.createNewAgent(params);
  }

  Future<void> deleteAgent(String id) {
    return _repository.deleteAgent(id);
  }
}

class NewAgentParams {
  final String name;
  final String organization;
  final List<String> contacts;

  NewAgentParams({
    required this.name,
    required this.organization,
    required this.contacts,
  });
}
