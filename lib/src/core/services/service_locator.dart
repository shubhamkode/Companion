import 'package:companion/src/core/database/local_database.dart';
import 'package:companion/src/core/router/router.dart';
import 'package:companion/src/features/agent/data/data_sources/local/local_agent_datasource.dart';
import 'package:companion/src/features/agent/data/repositories/agent_repository_impl.dart';
import 'package:companion/src/features/agent/domain/repositories/agent_repository.dart';
import 'package:companion/src/features/agent/domain/usecases/agent_usecase.dart';
import 'package:companion/src/features/company/data/data_sources/local/local_company_datasource.dart';
import 'package:companion/src/features/company/data/repositories/company_repository_impl.dart';
import 'package:companion/src/features/company/domain/repositories/company_repository.dart';
import 'package:companion/src/features/company/domain/usecases/company_usecase.dart';
import 'package:companion/src/features/settings/data/data_sources/local/local_settings_datasource.dart';
import 'package:companion/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:companion/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [Router] provider
final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});

/// [AppDatabase] Provider
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// [SharedPreferences] Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError("Provider not implemented yet.");
});

/// [DataSources]
final localAgentDataSourceProvider = Provider<LocalAgentDataSource>((ref) {
  final database = ref.watch(databaseProvider);
  return LocalAgentDataSourceImpl(database: database);
});

final localCompanyDataSourceProvider = Provider<LocalCompanyDataSource>((ref) {
  final database = ref.watch(databaseProvider);
  return LocalCompanyDataSourceImpl(database: database);
});

final localSettingsDataSourceProvider =
    Provider<LocalSettingsDataSource>((ref) {
  final instance = ref.watch(sharedPreferencesProvider);
  return LocalSettingsDataSourceImpl(instance);
});

/// [Repositories]
final agentRepositoryProvider = Provider<AgentRepository>((ref) {
  final localDataSource = ref.watch(localAgentDataSourceProvider);
  return AgentRepositoryImpl(localDataSource: localDataSource);
});
final companyRepositoryProvider = Provider<CompanyRepository>((ref) {
  final localDataSource = ref.watch(localCompanyDataSourceProvider);
  return CompanyRepositoryImpl(localCompanyDataSource: localDataSource);
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final dataSource = ref.watch(localSettingsDataSourceProvider);
  return SettingsRepositoryImpl(dataSource: dataSource);
});

/// [UseCases]
final agentUseCaseProvider = Provider<AgentUsecase>((ref) {
  final repository = ref.watch(agentRepositoryProvider);
  return AgentUsecase(
    repository: repository,
  );
});
final companyUseCaseProvider = Provider<CompanyUsecase>((ref) {
  final repository = ref.watch(companyRepositoryProvider);
  return CompanyUsecase(
    repository: repository,
  );
});
