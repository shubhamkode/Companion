import 'package:hive_flutter/hive_flutter.dart';

part 'company.g.dart';

@HiveType(typeId: 1)
class Company extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int color;

  Company({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
  });

  @override
  String toString() => "Company(id: $id,name: $name)";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "color": color,
    };
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      color: json['color'],
    );
  }
}
