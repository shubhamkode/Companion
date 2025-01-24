import 'dart:async';

import 'package:companion/src/features/company/data/data_sources/local/local_company_datasource.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/domain/repositories/company_repository.dart';
import 'package:companion/src/features/company/domain/usecases/company_usecase.dart';
import 'package:velocity_x/velocity_x.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final LocalCompanyDataSource _localCompanyDataSource;

  CompanyRepositoryImpl({
    required LocalCompanyDataSource localCompanyDataSource,
  }) : _localCompanyDataSource = localCompanyDataSource;

  @override
  Future<List<CompanyEntity>> getAllCompanies() {
    return _localCompanyDataSource
        .findAll()
        .then((c) => c.builder(CompanyEntity.fromModel));
  }

  @override
  Future<void> createNewCompany(NewCompanyParams params) {
    return _localCompanyDataSource.create(params);
  }

  @override
  deleteCompany(String id) {
    return _localCompanyDataSource.deleteById(id);
  }
}
