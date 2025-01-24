import 'dart:async';

import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/domain/repositories/company_repository.dart';

class CompanyUsecase {
  final CompanyRepository _repository;

  CompanyUsecase({
    required CompanyRepository repository,
  }) : _repository = repository;

  FutureOr<List<CompanyEntity>> getAllCompanies() {
    return _repository.getAllCompanies();
  }

  Future<void> newCompany(NewCompanyParams params) {
    return _repository.createNewCompany(params);
  }

  deleteCompany(String id) {
    return _repository.deleteCompany(id);
  }
}

class NewCompanyParams {
  final String name, description;

  NewCompanyParams({
    required this.name,
    required this.description,
  });
}
