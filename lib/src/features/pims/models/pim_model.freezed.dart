// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pim_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PimModel _$PimModelFromJson(Map<String, dynamic> json) {
  return _PimModel.fromJson(json);
}

/// @nodoc
mixin _$PimModel {
  String get id => throw _privateConstructorUsedError;
  String get digits => throw _privateConstructorUsedError;
  String get created => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_id')
  String get contactId => throw _privateConstructorUsedError;

  /// Serializes this PimModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PimModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PimModelCopyWith<PimModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PimModelCopyWith<$Res> {
  factory $PimModelCopyWith(PimModel value, $Res Function(PimModel) then) =
      _$PimModelCopyWithImpl<$Res, PimModel>;
  @useResult
  $Res call(
      {String id,
      String digits,
      String created,
      @JsonKey(name: 'contact_id') String contactId});
}

/// @nodoc
class _$PimModelCopyWithImpl<$Res, $Val extends PimModel>
    implements $PimModelCopyWith<$Res> {
  _$PimModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PimModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? digits = null,
    Object? created = null,
    Object? contactId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      digits: null == digits
          ? _value.digits
          : digits // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      contactId: null == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PimModelImplCopyWith<$Res>
    implements $PimModelCopyWith<$Res> {
  factory _$$PimModelImplCopyWith(
          _$PimModelImpl value, $Res Function(_$PimModelImpl) then) =
      __$$PimModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String digits,
      String created,
      @JsonKey(name: 'contact_id') String contactId});
}

/// @nodoc
class __$$PimModelImplCopyWithImpl<$Res>
    extends _$PimModelCopyWithImpl<$Res, _$PimModelImpl>
    implements _$$PimModelImplCopyWith<$Res> {
  __$$PimModelImplCopyWithImpl(
      _$PimModelImpl _value, $Res Function(_$PimModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PimModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? digits = null,
    Object? created = null,
    Object? contactId = null,
  }) {
    return _then(_$PimModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      digits: null == digits
          ? _value.digits
          : digits // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      contactId: null == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PimModelImpl implements _PimModel {
  _$PimModelImpl(
      {required this.id,
      required this.digits,
      required this.created,
      @JsonKey(name: 'contact_id') required this.contactId});

  factory _$PimModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PimModelImplFromJson(json);

  @override
  final String id;
  @override
  final String digits;
  @override
  final String created;
  @override
  @JsonKey(name: 'contact_id')
  final String contactId;

  @override
  String toString() {
    return 'PimModel(id: $id, digits: $digits, created: $created, contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PimModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.digits, digits) || other.digits == digits) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, digits, created, contactId);

  /// Create a copy of PimModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PimModelImplCopyWith<_$PimModelImpl> get copyWith =>
      __$$PimModelImplCopyWithImpl<_$PimModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PimModelImplToJson(
      this,
    );
  }
}

abstract class _PimModel implements PimModel {
  factory _PimModel(
          {required final String id,
          required final String digits,
          required final String created,
          @JsonKey(name: 'contact_id') required final String contactId}) =
      _$PimModelImpl;

  factory _PimModel.fromJson(Map<String, dynamic> json) =
      _$PimModelImpl.fromJson;

  @override
  String get id;
  @override
  String get digits;
  @override
  String get created;
  @override
  @JsonKey(name: 'contact_id')
  String get contactId;

  /// Create a copy of PimModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PimModelImplCopyWith<_$PimModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
