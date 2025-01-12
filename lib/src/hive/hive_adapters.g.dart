// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 0;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      isDarkModeEnabled: fields[0] as bool,
      backupPath: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isDarkModeEnabled)
      ..writeByte(1)
      ..write(obj.backupPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContactModelAdapter extends TypeAdapter<ContactModel> {
  @override
  final int typeId = 1;

  @override
  ContactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactModel(
      id: fields[0] as String,
      name: fields[1] as String,
      distributor: fields[2] as String,
      created: fields[5] as String,
      hexColor: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.distributor)
      ..writeByte(5)
      ..write(obj.created)
      ..writeByte(7)
      ..write(obj.hexColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PimModelAdapter extends TypeAdapter<PimModel> {
  @override
  final int typeId = 2;

  @override
  PimModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PimModel(
      id: fields[0] as String,
      digits: fields[1] as String,
      created: fields[3] as String,
      contactId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PimModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.digits)
      ..writeByte(2)
      ..write(obj.contactId)
      ..writeByte(3)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PimModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompanyModelAdapter extends TypeAdapter<CompanyModel> {
  @override
  final int typeId = 3;

  @override
  CompanyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      hexColor: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.hexColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompanyToContactModelAdapter extends TypeAdapter<CompanyToContactModel> {
  @override
  final int typeId = 4;

  @override
  CompanyToContactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyToContactModel(
      id: fields[0] as String,
      companyId: fields[1] as String,
      contactId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyToContactModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.companyId)
      ..writeByte(2)
      ..write(obj.contactId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyToContactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
