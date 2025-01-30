import 'package:companion/src/core/database/tables.dart';
import 'package:companion/src/core/utils/uuid.dart';
import 'package:drift/drift.dart';
import 'package:velocity_x/velocity_x.dart';

part 'local_database.g.dart';

@DriftDatabase(
  tables: [
    CompanyTable,
    AgentTable,
    CompanyToAgentTable,
    PartyTable,
    TransactionTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
