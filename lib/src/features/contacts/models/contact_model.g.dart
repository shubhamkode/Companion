// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactModelImpl _$$ContactModelImplFromJson(Map<String, dynamic> json) =>
    _$ContactModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      distributor: json['distributor'] as String,
      created: json['created'] as String,
      hexColor: json['hexColor'] as String,
    );

Map<String, dynamic> _$$ContactModelImplToJson(_$ContactModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'distributor': instance.distributor,
      'created': instance.created,
      'hexColor': instance.hexColor,
    };
