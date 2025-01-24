import 'package:companion/src/features/settings/data/data_sources/local/local_settings_datasource.dart';
import 'package:companion/src/features/settings/domain/entity/settings_entity.dart';
import 'package:companion/src/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final LocalSettingsDataSource _dataSource;

  SettingsRepositoryImpl({
    required LocalSettingsDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  SettingsEntity getSettings() {
    return _dataSource.getSettings();
  }

  @override
  Future<void> updateSettings(SettingsEntity updatedSettings) {
    return _dataSource.updateSettings(updatedSettings);
  }
}
