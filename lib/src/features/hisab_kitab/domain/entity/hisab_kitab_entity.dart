import 'dart:ui';

import 'package:companion/src/core/database/local_database.dart';
import 'package:companion/src/core/database/tables.dart';
import 'package:companion/src/core/utils/extensions.dart';

class PartyEntity {
  final String id, name;
  final List<String> contacts;

  final String? email, address, city, state, country;

  final Color hexColor;
  final DateTime created;

  PartyEntity({
    required this.id,
    required this.name,
    required this.contacts,
    this.email,
    this.address,
    this.city,
    this.state,
    this.country,
    required this.hexColor,
    required this.created,
  });

  factory PartyEntity.fromModel(PartyModel model) {
    return PartyEntity(
      id: model.id,
      name: model.name,
      contacts: model.contacts,
      email: model.email,
      address: model.address,
      city: model.city,
      state: model.state,
      country: model.country,
      hexColor: model.hexColor.toColor(),
      created: model.created,
    );
  }
}

class TransactionEntity {
  final String id;
  final TransactionType type;
  final double amount;
  final String? description;
  final DateTime created;
  final String partyId;

  TransactionEntity({
    required this.id,
    required this.type,
    required this.amount,
    this.description,
    required this.created,
    required this.partyId,
  });

  factory TransactionEntity.fromModel(TransactionModel model) {
    return TransactionEntity(
      id: model.id,
      type: model.type,
      description: model.description,
      amount: model.amount,
      created: model.created,
      partyId: model.partyId,
    );
  }
}
