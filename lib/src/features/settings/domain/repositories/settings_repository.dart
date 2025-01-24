import 'package:companion/src/features/settings/domain/entity/settings_entity.dart';

abstract class SettingsRepository {
  SettingsEntity getSettings();

  Future<void> updateSettings(SettingsEntity updatedSettings);
}
