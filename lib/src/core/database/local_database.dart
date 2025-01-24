import 'package:companion/src/core/database/tables.dart';
import 'package:companion/src/core/utils/uuid.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

part 'local_database.g.dart';

@DriftDatabase(
  tables: [
    CompanyTable,
    AgentTable,
    CompanyToAgentTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'companion');
  }
}
