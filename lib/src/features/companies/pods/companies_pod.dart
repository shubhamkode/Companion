// import 'package:companion/src/features/companies/models/company_model.dart';
// import 'package:companion/src/features/contacts/pods/contact_pod.dart';
// import 'package:cuid2/cuid2.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:velocity_x/velocity_x.dart';

// part 'companies_pod.g.dart';

// @riverpod
// class CompaniesPod extends _$CompaniesPod {
//   @override
//   Future<List<Company>> build() async {
//     final box = Hive.box<Company>("companies");
//     return box.values.sortedByString((cmp) => cmp.name).toList();
//   }

//   Future<void> insertCompany({
//     required String name,
//     required String description,
//   }) async {
//     final box = Hive.box<Company>("companies");

//     final company = Company(
//       id: cuid(),
//       name: name,
//       description: description,
//       color: Vx.getMaterialColor(Vx.randomPrimaryColor).value,
//     );

//     await box.put(company.id, company);

//     ref.invalidateSelf();
//   }

//   Future<void> deleteCompany(String id) async {
//     final box = Hive.box<Company>("companies");
//     await box.delete(id);
//     ref.invalidateSelf();
//     ref.invalidate(contactPodProvider);
//   }
// }
