import 'package:companion/src/core/utils/uuid.dart';
import 'package:drift/drift.dart';
import 'package:velocity_x/velocity_x.dart';

mixin BaseTable on Table {
  TextColumn get id => text().clientDefault(uuid)();
  TextColumn get hexColor => text().clientDefault(
      () => Vx.randomPrimaryColor.toHex(leadingHashSign: true))();
  DateTimeColumn get created =>
      dateTime().clientDefault(() => DateTime.now())();
}

@DataClassName('AgentModel')
class AgentTable extends Table with BaseTable {
  TextColumn get name => text()();
  TextColumn get organization => text()();
  TextColumn get contacts => text().map(contactsConvertor)();
}

@DataClassName('CompanyModel')
class CompanyTable extends Table with BaseTable {
  TextColumn get name => text()();
  TextColumn get description => text()();
}

@DataClassName('CompanyToAgentModel')
class CompanyToAgentTable extends Table {
  @JsonKey('company_id')
  TextColumn get companyId =>
      text().named("company_id").references(CompanyTable, #id)();
  @JsonKey('agent_id')
  TextColumn get agentId =>
      text().named("agent_id").references(AgentTable, #id)();

  @override
  Set<Column<Object>> get primaryKey => {
        companyId,
        agentId,
      };
}

final contactsConvertor = TypeConverter.json<List<String>>(
  toJson: (col) => col.join(','),
  fromJson: (val) => (val as String).split(','),
);
