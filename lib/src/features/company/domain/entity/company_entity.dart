import 'dart:ui';

import 'package:companion/src/core/database/local_database.dart';
import 'package:companion/src/core/utils/extensions.dart';

class CompanyEntity {
  final String id, name, description;

  final Color hexColor;
  final DateTime created;

  CompanyEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.hexColor,
    required this.created,
  });

  factory CompanyEntity.fromModel(CompanyModel model) {
    return CompanyEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      hexColor: model.hexColor.toColor(),
      created: model.created,
    );
  }
}
