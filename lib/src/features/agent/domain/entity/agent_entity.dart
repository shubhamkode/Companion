import 'dart:convert';
import 'dart:ui';

import 'package:companion/src/core/database/local_database.dart';
import 'package:companion/src/core/utils/extensions.dart';

class AgentEntity {
  final String id;

  final String name;
  final String organization;
  final Color hexColor;

  final List<String> contacts;

  final DateTime created;

  AgentEntity({
    required this.id,
    required this.name,
    required this.organization,
    required this.hexColor,
    required this.contacts,
    required this.created,
  });

  factory AgentEntity.fromModel(AgentModel model) {
    return AgentEntity(
      id: model.id,
      name: model.name,
      organization: model.organization,
      hexColor: model.hexColor.toColor(),
      contacts: model.contacts,
      created: model.created,
    );
  }

  @override
  String toString() {
    return "AgentEntity {id: $id, name:$name, organization: $organization, contacts: ${jsonEncode(contacts)}, created: $created}";
  }
}
