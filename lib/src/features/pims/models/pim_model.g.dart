// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pim_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PimModelImpl _$$PimModelImplFromJson(Map<String, dynamic> json) =>
    _$PimModelImpl(
      id: json['id'] as String,
      digits: json['digits'] as String,
      created: json['created'] as String,
      contactId: json['contact_id'] as String,
    );

Map<String, dynamic> _$$PimModelImplToJson(_$PimModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'digits': instance.digits,
      'created': instance.created,
      'contact_id': instance.contactId,
    };
