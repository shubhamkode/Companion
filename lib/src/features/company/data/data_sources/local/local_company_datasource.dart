import 'dart:async';

import 'package:companion/src/core/database/local_database.dart';
import 'package:companion/src/features/company/domain/usecases/company_usecase.dart';

abstract class LocalCompanyDataSource {
  Future<List<CompanyModel>> findAll();

  Future<void> create(NewCompanyParams params);

  deleteById(String id) {}
}

class LocalCompanyDataSourceImpl implements LocalCompanyDataSource {
  final AppDatabase _database;
  LocalCompanyDataSourceImpl({
    required AppDatabase database,
  }) : _database = database;

  @override
  Future<List<CompanyModel>> findAll() {
    return _database.managers.companyTable.orderBy((o) => o.name.asc()).get();
  }

  @override
  Future<void> create(NewCompanyParams params) {
    return _database.managers.companyTable.create(
      (c) => c(name: params.name, description: params.description),
    );
  }

  @override
  Future<void> deleteById(String id) {
    return _database.managers.companyTable
        .filter((f) => f.id.equals(id))
        .delete();
  }
}
