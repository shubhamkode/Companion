// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comp_to_conc_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanyToContactModel _$CompanyToContactModelFromJson(
    Map<String, dynamic> json) {
  return _CompanyToContactModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyToContactModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_id')
  String get companyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_id')
  String get contactId => throw _privateConstructorUsedError;

  /// Serializes this CompanyToContactModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompanyToContactModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompanyToContactModelCopyWith<CompanyToContactModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyToContactModelCopyWith<$Res> {
  factory $CompanyToContactModelCopyWith(CompanyToContactModel value,
          $Res Function(CompanyToContactModel) then) =
      _$CompanyToContactModelCopyWithImpl<$Res, CompanyToContactModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'company_id') String companyId,
      @JsonKey(name: 'contact_id') String contactId});
}

/// @nodoc
class _$CompanyToContactModelCopyWithImpl<$Res,
        $Val extends CompanyToContactModel>
    implements $CompanyToContactModelCopyWith<$Res> {
  _$CompanyToContactModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompanyToContactModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? contactId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      contactId: null == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompanyToContactModelImplCopyWith<$Res>
    implements $CompanyToContactModelCopyWith<$Res> {
  factory _$$CompanyToContactModelImplCopyWith(
          _$CompanyToContactModelImpl value,
          $Res Function(_$CompanyToContactModelImpl) then) =
      __$$CompanyToContactModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'company_id') String companyId,
      @JsonKey(name: 'contact_id') String contactId});
}

/// @nodoc
class __$$CompanyToContactModelImplCopyWithImpl<$Res>
    extends _$CompanyToContactModelCopyWithImpl<$Res,
        _$CompanyToContactModelImpl>
    implements _$$CompanyToContactModelImplCopyWith<$Res> {
  __$$CompanyToContactModelImplCopyWithImpl(_$CompanyToContactModelImpl _value,
      $Res Function(_$CompanyToContactModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompanyToContactModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? contactId = null,
  }) {
    return _then(_$CompanyToContactModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
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
class _$CompanyToContactModelImpl implements _CompanyToContactModel {
  _$CompanyToContactModelImpl(
      {required this.id,
      @JsonKey(name: 'company_id') required this.companyId,
      @JsonKey(name: 'contact_id') required this.contactId});

  factory _$CompanyToContactModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyToContactModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'company_id')
  final String companyId;
  @override
  @JsonKey(name: 'contact_id')
  final String contactId;

  @override
  String toString() {
    return 'CompanyToContactModel(id: $id, companyId: $companyId, contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyToContactModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, companyId, contactId);

  /// Create a copy of CompanyToContactModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyToContactModelImplCopyWith<_$CompanyToContactModelImpl>
      get copyWith => __$$CompanyToContactModelImplCopyWithImpl<
          _$CompanyToContactModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyToContactModelImplToJson(
      this,
    );
  }
}

abstract class _CompanyToContactModel implements CompanyToContactModel {
  factory _CompanyToContactModel(
          {required final String id,
          @JsonKey(name: 'company_id') required final String companyId,
          @JsonKey(name: 'contact_id') required final String contactId}) =
      _$CompanyToContactModelImpl;

  factory _CompanyToContactModel.fromJson(Map<String, dynamic> json) =
      _$CompanyToContactModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'company_id')
  String get companyId;
  @override
  @JsonKey(name: 'contact_id')
  String get contactId;

  /// Create a copy of CompanyToContactModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompanyToContactModelImplCopyWith<_$CompanyToContactModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
