// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsModelImpl _$$SettingsModelImplFromJson(Map<String, dynamic> json) =>
    _$SettingsModelImpl(
      isDarkModeEnabled: json['isDarkModeEnabled'] as bool? ?? false,
      backupPath: json['backupPath'] as String? ??
          '/storage/emulated/0/Download/Companion',
    );

Map<String, dynamic> _$$SettingsModelImplToJson(_$SettingsModelImpl instance) =>
    <String, dynamic>{
      'isDarkModeEnabled': instance.isDarkModeEnabled,
      'backupPath': instance.backupPath,
    };
