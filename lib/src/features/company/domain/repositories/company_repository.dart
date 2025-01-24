import 'dart:async';

import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/domain/usecases/company_usecase.dart';

abstract class CompanyRepository {
  FutureOr<List<CompanyEntity>> getAllCompanies();

  Future<void> createNewCompany(NewCompanyParams params);

  deleteCompany(String id) {}
}
