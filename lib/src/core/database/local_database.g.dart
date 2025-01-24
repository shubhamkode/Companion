// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $CompanyTableTable extends CompanyTable
    with TableInfo<$CompanyTableTable, CompanyModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: uuid);
  static const VerificationMeta _hexColorMeta =
      const VerificationMeta('hexColor');
  @override
  late final GeneratedColumn<String> hexColor = GeneratedColumn<String>(
      'hex_color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () =>
          VxColorExtension(Vx.randomPrimaryColor).toHex(leadingHashSign: true));
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
      'created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, hexColor, created, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'company_table';
  @override
  VerificationContext validateIntegrity(Insertable<CompanyModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hex_color')) {
      context.handle(_hexColorMeta,
          hexColor.isAcceptableOrUnknown(data['hex_color']!, _hexColorMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  CompanyModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      hexColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hex_color'])!,
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $CompanyTableTable createAlias(String alias) {
    return $CompanyTableTable(attachedDatabase, alias);
  }
}

class CompanyModel extends DataClass implements Insertable<CompanyModel> {
  final String id;
  final String hexColor;
  final DateTime created;
  final String name;
  final String description;
  const CompanyModel(
      {required this.id,
      required this.hexColor,
      required this.created,
      required this.name,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['hex_color'] = Variable<String>(hexColor);
    map['created'] = Variable<DateTime>(created);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    return map;
  }

  CompanyTableCompanion toCompanion(bool nullToAbsent) {
    return CompanyTableCompanion(
      id: Value(id),
      hexColor: Value(hexColor),
      created: Value(created),
      name: Value(name),
      description: Value(description),
    );
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyModel(
      id: serializer.fromJson<String>(json['id']),
      hexColor: serializer.fromJson<String>(json['hexColor']),
      created: serializer.fromJson<DateTime>(json['created']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'hexColor': serializer.toJson<String>(hexColor),
      'created': serializer.toJson<DateTime>(created),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  CompanyModel copyWith(
          {String? id,
          String? hexColor,
          DateTime? created,
          String? name,
          String? description}) =>
      CompanyModel(
        id: id ?? this.id,
        hexColor: hexColor ?? this.hexColor,
        created: created ?? this.created,
        name: name ?? this.name,
        description: description ?? this.description,
      );
  CompanyModel copyWithCompanion(CompanyTableCompanion data) {
    return CompanyModel(
      id: data.id.present ? data.id.value : this.id,
      hexColor: data.hexColor.present ? data.hexColor.value : this.hexColor,
      created: data.created.present ? data.created.value : this.created,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanyModel(')
          ..write('id: $id, ')
          ..write('hexColor: $hexColor, ')
          ..write('created: $created, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, hexColor, created, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyModel &&
          other.id == this.id &&
          other.hexColor == this.hexColor &&
          other.created == this.created &&
          other.name == this.name &&
          other.description == this.description);
}

class CompanyTableCompanion extends UpdateCompanion<CompanyModel> {
  final Value<String> id;
  final Value<String> hexColor;
  final Value<DateTime> created;
  final Value<String> name;
  final Value<String> description;
  final Value<int> rowid;
  const CompanyTableCompanion({
    this.id = const Value.absent(),
    this.hexColor = const Value.absent(),
    this.created = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompanyTableCompanion.insert({
    this.id = const Value.absent(),
    this.hexColor = const Value.absent(),
    this.created = const Value.absent(),
    required String name,
    required String description,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        description = Value(description);
  static Insertable<CompanyModel> custom({
    Expression<String>? id,
    Expression<String>? hexColor,
    Expression<DateTime>? created,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hexColor != null) 'hex_color': hexColor,
      if (created != null) 'created': created,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompanyTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? hexColor,
      Value<DateTime>? created,
      Value<String>? name,
      Value<String>? description,
      Value<int>? rowid}) {
    return CompanyTableCompanion(
      id: id ?? this.id,
      hexColor: hexColor ?? this.hexColor,
      created: created ?? this.created,
      name: name ?? this.name,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (hexColor.present) {
      map['hex_color'] = Variable<String>(hexColor.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyTableCompanion(')
          ..write('id: $id, ')
          ..write('hexColor: $hexColor, ')
          ..write('created: $created, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgentTableTable extends AgentTable
    with TableInfo<$AgentTableTable, AgentModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgentTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: uuid);
  static const VerificationMeta _hexColorMeta =
      const VerificationMeta('hexColor');
  @override
  late final GeneratedColumn<String> hexColor = GeneratedColumn<String>(
      'hex_color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () =>
          VxColorExtension(Vx.randomPrimaryColor).toHex(leadingHashSign: true));
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
      'created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _organizationMeta =
      const VerificationMeta('organization');
  @override
  late final GeneratedColumn<String> organization = GeneratedColumn<String>(
      'organization', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactsMeta =
      const VerificationMeta('contacts');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> contacts =
      GeneratedColumn<String>('contacts', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($AgentTableTable.$convertercontacts);
  @override
  List<GeneratedColumn> get $columns =>
      [id, hexColor, created, name, organization, contacts];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agent_table';
  @override
  VerificationContext validateIntegrity(Insertable<AgentModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hex_color')) {
      context.handle(_hexColorMeta,
          hexColor.isAcceptableOrUnknown(data['hex_color']!, _hexColorMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('organization')) {
      context.handle(
          _organizationMeta,
          organization.isAcceptableOrUnknown(
              data['organization']!, _organizationMeta));
    } else if (isInserting) {
      context.missing(_organizationMeta);
    }
    context.handle(_contactsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AgentModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgentModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      hexColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hex_color'])!,
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      organization: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}organization'])!,
      contacts: $AgentTableTable.$convertercontacts.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contacts'])!),
    );
  }

  @override
  $AgentTableTable createAlias(String alias) {
    return $AgentTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<List<String>, String, String> $convertercontacts =
      contactsConvertor;
}

class AgentModel extends DataClass implements Insertable<AgentModel> {
  final String id;
  final String hexColor;
  final DateTime created;
  final String name;
  final String organization;
  final List<String> contacts;
  const AgentModel(
      {required this.id,
      required this.hexColor,
      required this.created,
      required this.name,
      required this.organization,
      required this.contacts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['hex_color'] = Variable<String>(hexColor);
    map['created'] = Variable<DateTime>(created);
    map['name'] = Variable<String>(name);
    map['organization'] = Variable<String>(organization);
    {
      map['contacts'] =
          Variable<String>($AgentTableTable.$convertercontacts.toSql(contacts));
    }
    return map;
  }

  AgentTableCompanion toCompanion(bool nullToAbsent) {
    return AgentTableCompanion(
      id: Value(id),
      hexColor: Value(hexColor),
      created: Value(created),
      name: Value(name),
      organization: Value(organization),
      contacts: Value(contacts),
    );
  }

  factory AgentModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgentModel(
      id: serializer.fromJson<String>(json['id']),
      hexColor: serializer.fromJson<String>(json['hexColor']),
      created: serializer.fromJson<DateTime>(json['created']),
      name: serializer.fromJson<String>(json['name']),
      organization: serializer.fromJson<String>(json['organization']),
      contacts: $AgentTableTable.$convertercontacts
          .fromJson(serializer.fromJson<String>(json['contacts'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'hexColor': serializer.toJson<String>(hexColor),
      'created': serializer.toJson<DateTime>(created),
      'name': serializer.toJson<String>(name),
      'organization': serializer.toJson<String>(organization),
      'contacts': serializer
          .toJson<String>($AgentTableTable.$convertercontacts.toJson(contacts)),
    };
  }

  AgentModel copyWith(
          {String? id,
          String? hexColor,
          DateTime? created,
          String? name,
          String? organization,
          List<String>? contacts}) =>
      AgentModel(
        id: id ?? this.id,
        hexColor: hexColor ?? this.hexColor,
        created: created ?? this.created,
        name: name ?? this.name,
        organization: organization ?? this.organization,
        contacts: contacts ?? this.contacts,
      );
  AgentModel copyWithCompanion(AgentTableCompanion data) {
    return AgentModel(
      id: data.id.present ? data.id.value : this.id,
      hexColor: data.hexColor.present ? data.hexColor.value : this.hexColor,
      created: data.created.present ? data.created.value : this.created,
      name: data.name.present ? data.name.value : this.name,
      organization: data.organization.present
          ? data.organization.value
          : this.organization,
      contacts: data.contacts.present ? data.contacts.value : this.contacts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgentModel(')
          ..write('id: $id, ')
          ..write('hexColor: $hexColor, ')
          ..write('created: $created, ')
          ..write('name: $name, ')
          ..write('organization: $organization, ')
          ..write('contacts: $contacts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, hexColor, created, name, organization, contacts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgentModel &&
          other.id == this.id &&
          other.hexColor == this.hexColor &&
          other.created == this.created &&
          other.name == this.name &&
          other.organization == this.organization &&
          other.contacts == this.contacts);
}

class AgentTableCompanion extends UpdateCompanion<AgentModel> {
  final Value<String> id;
  final Value<String> hexColor;
  final Value<DateTime> created;
  final Value<String> name;
  final Value<String> organization;
  final Value<List<String>> contacts;
  final Value<int> rowid;
  const AgentTableCompanion({
    this.id = const Value.absent(),
    this.hexColor = const Value.absent(),
    this.created = const Value.absent(),
    this.name = const Value.absent(),
    this.organization = const Value.absent(),
    this.contacts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgentTableCompanion.insert({
    this.id = const Value.absent(),
    this.hexColor = const Value.absent(),
    this.created = const Value.absent(),
    required String name,
    required String organization,
    required List<String> contacts,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        organization = Value(organization),
        contacts = Value(contacts);
  static Insertable<AgentModel> custom({
    Expression<String>? id,
    Expression<String>? hexColor,
    Expression<DateTime>? created,
    Expression<String>? name,
    Expression<String>? organization,
    Expression<String>? contacts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hexColor != null) 'hex_color': hexColor,
      if (created != null) 'created': created,
      if (name != null) 'name': name,
      if (organization != null) 'organization': organization,
      if (contacts != null) 'contacts': contacts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgentTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? hexColor,
      Value<DateTime>? created,
      Value<String>? name,
      Value<String>? organization,
      Value<List<String>>? contacts,
      Value<int>? rowid}) {
    return AgentTableCompanion(
      id: id ?? this.id,
      hexColor: hexColor ?? this.hexColor,
      created: created ?? this.created,
      name: name ?? this.name,
      organization: organization ?? this.organization,
      contacts: contacts ?? this.contacts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (hexColor.present) {
      map['hex_color'] = Variable<String>(hexColor.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (organization.present) {
      map['organization'] = Variable<String>(organization.value);
    }
    if (contacts.present) {
      map['contacts'] = Variable<String>(
          $AgentTableTable.$convertercontacts.toSql(contacts.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgentTableCompanion(')
          ..write('id: $id, ')
          ..write('hexColor: $hexColor, ')
          ..write('created: $created, ')
          ..write('name: $name, ')
          ..write('organization: $organization, ')
          ..write('contacts: $contacts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompanyToAgentTableTable extends CompanyToAgentTable
    with TableInfo<$CompanyToAgentTableTable, CompanyToAgentModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanyToAgentTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
      'company_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES company_table (id)'));
  static const VerificationMeta _agentIdMeta =
      const VerificationMeta('agentId');
  @override
  late final GeneratedColumn<String> agentId = GeneratedColumn<String>(
      'agent_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agent_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [companyId, agentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'company_to_agent_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<CompanyToAgentModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('agent_id')) {
      context.handle(_agentIdMeta,
          agentId.isAcceptableOrUnknown(data['agent_id']!, _agentIdMeta));
    } else if (isInserting) {
      context.missing(_agentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {companyId, agentId};
  @override
  CompanyToAgentModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyToAgentModel(
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_id'])!,
      agentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agent_id'])!,
    );
  }

  @override
  $CompanyToAgentTableTable createAlias(String alias) {
    return $CompanyToAgentTableTable(attachedDatabase, alias);
  }
}

class CompanyToAgentModel extends DataClass
    implements Insertable<CompanyToAgentModel> {
  final String companyId;
  final String agentId;
  const CompanyToAgentModel({required this.companyId, required this.agentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['company_id'] = Variable<String>(companyId);
    map['agent_id'] = Variable<String>(agentId);
    return map;
  }

  CompanyToAgentTableCompanion toCompanion(bool nullToAbsent) {
    return CompanyToAgentTableCompanion(
      companyId: Value(companyId),
      agentId: Value(agentId),
    );
  }

  factory CompanyToAgentModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyToAgentModel(
      companyId: serializer.fromJson<String>(json['company_id']),
      agentId: serializer.fromJson<String>(json['agent_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'company_id': serializer.toJson<String>(companyId),
      'agent_id': serializer.toJson<String>(agentId),
    };
  }

  CompanyToAgentModel copyWith({String? companyId, String? agentId}) =>
      CompanyToAgentModel(
        companyId: companyId ?? this.companyId,
        agentId: agentId ?? this.agentId,
      );
  CompanyToAgentModel copyWithCompanion(CompanyToAgentTableCompanion data) {
    return CompanyToAgentModel(
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      agentId: data.agentId.present ? data.agentId.value : this.agentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanyToAgentModel(')
          ..write('companyId: $companyId, ')
          ..write('agentId: $agentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(companyId, agentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyToAgentModel &&
          other.companyId == this.companyId &&
          other.agentId == this.agentId);
}

class CompanyToAgentTableCompanion
    extends UpdateCompanion<CompanyToAgentModel> {
  final Value<String> companyId;
  final Value<String> agentId;
  final Value<int> rowid;
  const CompanyToAgentTableCompanion({
    this.companyId = const Value.absent(),
    this.agentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompanyToAgentTableCompanion.insert({
    required String companyId,
    required String agentId,
    this.rowid = const Value.absent(),
  })  : companyId = Value(companyId),
        agentId = Value(agentId);
  static Insertable<CompanyToAgentModel> custom({
    Expression<String>? companyId,
    Expression<String>? agentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (companyId != null) 'company_id': companyId,
      if (agentId != null) 'agent_id': agentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompanyToAgentTableCompanion copyWith(
      {Value<String>? companyId, Value<String>? agentId, Value<int>? rowid}) {
    return CompanyToAgentTableCompanion(
      companyId: companyId ?? this.companyId,
      agentId: agentId ?? this.agentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (agentId.present) {
      map['agent_id'] = Variable<String>(agentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyToAgentTableCompanion(')
          ..write('companyId: $companyId, ')
          ..write('agentId: $agentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CompanyTableTable companyTable = $CompanyTableTable(this);
  late final $AgentTableTable agentTable = $AgentTableTable(this);
  late final $CompanyToAgentTableTable companyToAgentTable =
      $CompanyToAgentTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [companyTable, agentTable, companyToAgentTable];
}

typedef $$CompanyTableTableCreateCompanionBuilder = CompanyTableCompanion
    Function({
  Value<String> id,
  Value<String> hexColor,
  Value<DateTime> created,
  required String name,
  required String description,
  Value<int> rowid,
});
typedef $$CompanyTableTableUpdateCompanionBuilder = CompanyTableCompanion
    Function({
  Value<String> id,
  Value<String> hexColor,
  Value<DateTime> created,
  Value<String> name,
  Value<String> description,
  Value<int> rowid,
});

final class $$CompanyTableTableReferences
    extends BaseReferences<_$AppDatabase, $CompanyTableTable, CompanyModel> {
  $$CompanyTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CompanyToAgentTableTable,
      List<CompanyToAgentModel>> _companyToAgentTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.companyToAgentTable,
          aliasName: $_aliasNameGenerator(
              db.companyTable.id, db.companyToAgentTable.companyId));

  $$CompanyToAgentTableTableProcessedTableManager get companyToAgentTableRefs {
    final manager =
        $$CompanyToAgentTableTableTableManager($_db, $_db.companyToAgentTable)
            .filter((f) => f.companyId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_companyToAgentTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CompanyTableTableFilterComposer
    extends Composer<_$AppDatabase, $CompanyTableTable> {
  $$CompanyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hexColor => $composableBuilder(
      column: $table.hexColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  Expression<bool> companyToAgentTableRefs(
      Expression<bool> Function($$CompanyToAgentTableTableFilterComposer f) f) {
    final $$CompanyToAgentTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.companyToAgentTable,
        getReferencedColumn: (t) => t.companyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompanyToAgentTableTableFilterComposer(
              $db: $db,
              $table: $db.companyToAgentTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CompanyTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanyTableTable> {
  $$CompanyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hexColor => $composableBuilder(
      column: $table.hexColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$CompanyTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanyTableTable> {
  $$CompanyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get hexColor =>
      $composableBuilder(column: $table.hexColor, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  Expression<T> companyToAgentTableRefs<T extends Object>(
      Expression<T> Function($$CompanyToAgentTableTableAnnotationComposer a)
          f) {
    final $$CompanyToAgentTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.companyToAgentTable,
            getReferencedColumn: (t) => t.companyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CompanyToAgentTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.companyToAgentTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CompanyTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CompanyTableTable,
    CompanyModel,
    $$CompanyTableTableFilterComposer,
    $$CompanyTableTableOrderingComposer,
    $$CompanyTableTableAnnotationComposer,
    $$CompanyTableTableCreateCompanionBuilder,
    $$CompanyTableTableUpdateCompanionBuilder,
    (CompanyModel, $$CompanyTableTableReferences),
    CompanyModel,
    PrefetchHooks Function({bool companyToAgentTableRefs})> {
  $$CompanyTableTableTableManager(_$AppDatabase db, $CompanyTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompanyTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> hexColor = const Value.absent(),
            Value<DateTime> created = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CompanyTableCompanion(
            id: id,
            hexColor: hexColor,
            created: created,
            name: name,
            description: description,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> hexColor = const Value.absent(),
            Value<DateTime> created = const Value.absent(),
            required String name,
            required String description,
            Value<int> rowid = const Value.absent(),
          }) =>
              CompanyTableCompanion.insert(
            id: id,
            hexColor: hexColor,
            created: created,
            name: name,
            description: description,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CompanyTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({companyToAgentTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (companyToAgentTableRefs) db.companyToAgentTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (companyToAgentTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CompanyTableTableReferences
                            ._companyToAgentTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CompanyTableTableReferences(db, table, p0)
                                .companyToAgentTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.companyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CompanyTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CompanyTableTable,
    CompanyModel,
    $$CompanyTableTableFilterComposer,
    $$CompanyTableTableOrderingComposer,
    $$CompanyTableTableAnnotationComposer,
    $$CompanyTableTableCreateCompanionBuilder,
    $$CompanyTableTableUpdateCompanionBuilder,
    (CompanyModel, $$CompanyTableTableReferences),
    CompanyModel,
    PrefetchHooks Function({bool companyToAgentTableRefs})>;
typedef $$AgentTableTableCreateCompanionBuilder = AgentTableCompanion Function({
  Value<String> id,
  Value<String> hexColor,
  Value<DateTime> created,
  required String name,
  required String organization,
  required List<String> contacts,
  Value<int> rowid,
});
typedef $$AgentTableTableUpdateCompanionBuilder = AgentTableCompanion Function({
  Value<String> id,
  Value<String> hexColor,
  Value<DateTime> created,
  Value<String> name,
  Value<String> organization,
  Value<List<String>> contacts,
  Value<int> rowid,
});

final class $$AgentTableTableReferences
    extends BaseReferences<_$AppDatabase, $AgentTableTable, AgentModel> {
  $$AgentTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CompanyToAgentTableTable,
      List<CompanyToAgentModel>> _companyToAgentTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.companyToAgentTable,
          aliasName: $_aliasNameGenerator(
              db.agentTable.id, db.companyToAgentTable.agentId));

  $$CompanyToAgentTableTableProcessedTableManager get companyToAgentTableRefs {
    final manager =
        $$CompanyToAgentTableTableTableManager($_db, $_db.companyToAgentTable)
            .filter((f) => f.agentId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_companyToAgentTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AgentTableTableFilterComposer
    extends Composer<_$AppDatabase, $AgentTableTable> {
  $$AgentTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hexColor => $composableBuilder(
      column: $table.hexColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get organization => $composableBuilder(
      column: $table.organization, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get contacts => $composableBuilder(
          column: $table.contacts,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  Expression<bool> companyToAgentTableRefs(
      Expression<bool> Function($$CompanyToAgentTableTableFilterComposer f) f) {
    final $$CompanyToAgentTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.companyToAgentTable,
        getReferencedColumn: (t) => t.agentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompanyToAgentTableTableFilterComposer(
              $db: $db,
              $table: $db.companyToAgentTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AgentTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AgentTableTable> {
  $$AgentTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hexColor => $composableBuilder(
      column: $table.hexColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get organization => $composableBuilder(
      column: $table.organization,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contacts => $composableBuilder(
      column: $table.contacts, builder: (column) => ColumnOrderings(column));
}

class $$AgentTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgentTableTable> {
  $$AgentTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get hexColor =>
      $composableBuilder(column: $table.hexColor, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get organization => $composableBuilder(
      column: $table.organization, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get contacts =>
      $composableBuilder(column: $table.contacts, builder: (column) => column);

  Expression<T> companyToAgentTableRefs<T extends Object>(
      Expression<T> Function($$CompanyToAgentTableTableAnnotationComposer a)
          f) {
    final $$CompanyToAgentTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.companyToAgentTable,
            getReferencedColumn: (t) => t.agentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CompanyToAgentTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.companyToAgentTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AgentTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AgentTableTable,
    AgentModel,
    $$AgentTableTableFilterComposer,
    $$AgentTableTableOrderingComposer,
    $$AgentTableTableAnnotationComposer,
    $$AgentTableTableCreateCompanionBuilder,
    $$AgentTableTableUpdateCompanionBuilder,
    (AgentModel, $$AgentTableTableReferences),
    AgentModel,
    PrefetchHooks Function({bool companyToAgentTableRefs})> {
  $$AgentTableTableTableManager(_$AppDatabase db, $AgentTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgentTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgentTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgentTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> hexColor = const Value.absent(),
            Value<DateTime> created = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> organization = const Value.absent(),
            Value<List<String>> contacts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AgentTableCompanion(
            id: id,
            hexColor: hexColor,
            created: created,
            name: name,
            organization: organization,
            contacts: contacts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> hexColor = const Value.absent(),
            Value<DateTime> created = const Value.absent(),
            required String name,
            required String organization,
            required List<String> contacts,
            Value<int> rowid = const Value.absent(),
          }) =>
              AgentTableCompanion.insert(
            id: id,
            hexColor: hexColor,
            created: created,
            name: name,
            organization: organization,
            contacts: contacts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AgentTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({companyToAgentTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (companyToAgentTableRefs) db.companyToAgentTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (companyToAgentTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AgentTableTableReferences
                            ._companyToAgentTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AgentTableTableReferences(db, table, p0)
                                .companyToAgentTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.agentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AgentTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AgentTableTable,
    AgentModel,
    $$AgentTableTableFilterComposer,
    $$AgentTableTableOrderingComposer,
    $$AgentTableTableAnnotationComposer,
    $$AgentTableTableCreateCompanionBuilder,
    $$AgentTableTableUpdateCompanionBuilder,
    (AgentModel, $$AgentTableTableReferences),
    AgentModel,
    PrefetchHooks Function({bool companyToAgentTableRefs})>;
typedef $$CompanyToAgentTableTableCreateCompanionBuilder
    = CompanyToAgentTableCompanion Function({
  required String companyId,
  required String agentId,
  Value<int> rowid,
});
typedef $$CompanyToAgentTableTableUpdateCompanionBuilder
    = CompanyToAgentTableCompanion Function({
  Value<String> companyId,
  Value<String> agentId,
  Value<int> rowid,
});

final class $$CompanyToAgentTableTableReferences extends BaseReferences<
    _$AppDatabase, $CompanyToAgentTableTable, CompanyToAgentModel> {
  $$CompanyToAgentTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CompanyTableTable _companyIdTable(_$AppDatabase db) =>
      db.companyTable.createAlias($_aliasNameGenerator(
          db.companyToAgentTable.companyId, db.companyTable.id));

  $$CompanyTableTableProcessedTableManager get companyId {
    final manager = $$CompanyTableTableTableManager($_db, $_db.companyTable)
        .filter((f) => f.id($_item.companyId));
    final item = $_typedResult.readTableOrNull(_companyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AgentTableTable _agentIdTable(_$AppDatabase db) =>
      db.agentTable.createAlias($_aliasNameGenerator(
          db.companyToAgentTable.agentId, db.agentTable.id));

  $$AgentTableTableProcessedTableManager get agentId {
    final manager = $$AgentTableTableTableManager($_db, $_db.agentTable)
        .filter((f) => f.id($_item.agentId));
    final item = $_typedResult.readTableOrNull(_agentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CompanyToAgentTableTableFilterComposer
    extends Composer<_$AppDatabase, $CompanyToAgentTableTable> {
  $$CompanyToAgentTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CompanyTableTableFilterComposer get companyId {
    final $$CompanyTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.companyId,
        referencedTable: $db.companyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompanyTableTableFilterComposer(
              $db: $db,
              $table: $db.companyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AgentTableTableFilterComposer get agentId {
    final $$AgentTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.agentId,
        referencedTable: $db.agentTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgentTableTableFilterComposer(
              $db: $db,
              $table: $db.agentTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CompanyToAgentTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanyToAgentTableTable> {
  $$CompanyToAgentTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CompanyTableTableOrderingComposer get companyId {
    final $$CompanyTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.companyId,
        referencedTable: $db.companyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompanyTableTableOrderingComposer(
              $db: $db,
              $table: $db.companyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AgentTableTableOrderingComposer get agentId {
    final $$AgentTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.agentId,
        referencedTable: $db.agentTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgentTableTableOrderingComposer(
              $db: $db,
              $table: $db.agentTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CompanyToAgentTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanyToAgentTableTable> {
  $$CompanyToAgentTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CompanyTableTableAnnotationComposer get companyId {
    final $$CompanyTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.companyId,
        referencedTable: $db.companyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompanyTableTableAnnotationComposer(
              $db: $db,
              $table: $db.companyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AgentTableTableAnnotationComposer get agentId {
    final $$AgentTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.agentId,
        referencedTable: $db.agentTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgentTableTableAnnotationComposer(
              $db: $db,
              $table: $db.agentTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CompanyToAgentTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CompanyToAgentTableTable,
    CompanyToAgentModel,
    $$CompanyToAgentTableTableFilterComposer,
    $$CompanyToAgentTableTableOrderingComposer,
    $$CompanyToAgentTableTableAnnotationComposer,
    $$CompanyToAgentTableTableCreateCompanionBuilder,
    $$CompanyToAgentTableTableUpdateCompanionBuilder,
    (CompanyToAgentModel, $$CompanyToAgentTableTableReferences),
    CompanyToAgentModel,
    PrefetchHooks Function({bool companyId, bool agentId})> {
  $$CompanyToAgentTableTableTableManager(
      _$AppDatabase db, $CompanyToAgentTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanyToAgentTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanyToAgentTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompanyToAgentTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> companyId = const Value.absent(),
            Value<String> agentId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CompanyToAgentTableCompanion(
            companyId: companyId,
            agentId: agentId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String companyId,
            required String agentId,
            Value<int> rowid = const Value.absent(),
          }) =>
              CompanyToAgentTableCompanion.insert(
            companyId: companyId,
            agentId: agentId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CompanyToAgentTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({companyId = false, agentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (companyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.companyId,
                    referencedTable: $$CompanyToAgentTableTableReferences
                        ._companyIdTable(db),
                    referencedColumn: $$CompanyToAgentTableTableReferences
                        ._companyIdTable(db)
                        .id,
                  ) as T;
                }
                if (agentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.agentId,
                    referencedTable:
                        $$CompanyToAgentTableTableReferences._agentIdTable(db),
                    referencedColumn: $$CompanyToAgentTableTableReferences
                        ._agentIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CompanyToAgentTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CompanyToAgentTableTable,
    CompanyToAgentModel,
    $$CompanyToAgentTableTableFilterComposer,
    $$CompanyToAgentTableTableOrderingComposer,
    $$CompanyToAgentTableTableAnnotationComposer,
    $$CompanyToAgentTableTableCreateCompanionBuilder,
    $$CompanyToAgentTableTableUpdateCompanionBuilder,
    (CompanyToAgentModel, $$CompanyToAgentTableTableReferences),
    CompanyToAgentModel,
    PrefetchHooks Function({bool companyId, bool agentId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CompanyTableTableTableManager get companyTable =>
      $$CompanyTableTableTableManager(_db, _db.companyTable);
  $$AgentTableTableTableManager get agentTable =>
      $$AgentTableTableTableManager(_db, _db.agentTable);
  $$CompanyToAgentTableTableTableManager get companyToAgentTable =>
      $$CompanyToAgentTableTableTableManager(_db, _db.companyToAgentTable);
}
