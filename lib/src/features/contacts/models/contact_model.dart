import 'package:companion/src/features/companies/models/company.dart';
import 'package:hive/hive.dart';
import 'package:velocity_x/velocity_x.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 2)
class Contact extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String distributor;

  @HiveField(3)
  final HiveList<Pim> pims;

  @HiveField(4)
  final HiveList<Company> companies;

  @HiveField(5)
  final String created;

  @HiveField(6)
  final int color;

  Contact({
    required this.id,
    required this.name,
    required this.distributor,
    required this.pims,
    required this.companies,
    required this.created,
    required this.color,
  });

  @override
  String toString() => "Contact(id: $id)";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "distributor": distributor,
      "pims": pims.builder((pim) => pim.id),
      "companies": companies.builder((cmp) => cmp.id),
      "created": created,
      "color": color,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      distributor: json['distributor'],
      color: json['color'],
      created: json['created'],
      pims: json['pims'],
      companies: json['companies'],
    );
  }
}

@HiveType(typeId: 3)
class Pim extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String contact;

  Pim({
    required this.id,
    required this.contact,
  });

  @override
  String toString() => "Pim(id: $id, contact: $contact)";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "contact": contact,
    };
  }

  factory Pim.fromJson(Map<String, dynamic> json) {
    return Pim(
      id: json['id'],
      contact: json['contact'],
    );
  }
}
