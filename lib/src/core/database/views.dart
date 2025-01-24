// part 'views.g.dart';

// abstract class CompanyToAgentView extends View {
//   CompanyTable get companyTable;
//   AgentTable get agentTable;
//   CompanyToAgentTable get companyToAgentTable;

//   @override
//   Query as() => select([
//         agentTable.id,
//         agentTable.name,
//         agentTable.organization,
//         agentTable.contacts,
//         agentTable.hexColor,
//         //
//         companyTable.id,
//         companyTable.name,
//         companyTable.description,
//         companyTable.hexColor,
//       ]).from(companyToAgentTable).join([
//         innerJoin(
//             agentTable, agentTable.id.equalsExp(companyToAgentTable.agentId))
//       ]).join([
//         innerJoin(companyTable,
//             companyTable.id.equalsExp(companyToAgentTable.companyId))
//       ]);
// }
