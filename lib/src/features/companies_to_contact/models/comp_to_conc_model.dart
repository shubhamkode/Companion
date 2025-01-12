import 'package:freezed_annotation/freezed_annotation.dart';

part 'comp_to_conc_model.freezed.dart';
part 'comp_to_conc_model.g.dart';

@freezed
class CompanyToContactModel with _$CompanyToContactModel {
  factory CompanyToContactModel({
    required String id,
    @JsonKey(name: 'company_id') required String companyId,
    @JsonKey(name: 'contact_id') required String contactId,
  }) = _CompanyToContactModel;

  factory CompanyToContactModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyToContactModelFromJson(json);
}
