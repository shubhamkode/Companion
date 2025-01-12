import 'package:freezed_annotation/freezed_annotation.dart';

part 'pim_model.freezed.dart';
part 'pim_model.g.dart';

@freezed
class PimModel with _$PimModel {
  factory PimModel({
    required String id,
    required String digits,
    required String created,
    @JsonKey(name: 'contact_id') required String contactId,
  }) = _PimModel;

  factory PimModel.fromJson(Map<String, dynamic> json) =>
      _$PimModelFromJson(json);
}
