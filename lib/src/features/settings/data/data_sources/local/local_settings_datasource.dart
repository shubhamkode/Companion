import 'package:companion/src/features/settings/domain/entity/settings_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kIsDarkModeEnabledKey = 'isDarkModeEnabled';
const String kBackupPath = 'backupPath';

// '/storage/emulated/0/Download/';
abstract class LocalSettingsDataSource {
  SettingsEntity getSettings();

  updateSettings(SettingsEntity updatedSettings) {}
}

class LocalSettingsDataSourceImpl implements LocalSettingsDataSource {
  final SharedPreferences sharedPreferencesInstance;

  LocalSettingsDataSourceImpl(
    this.sharedPreferencesInstance,
  );

  @override
  SettingsEntity getSettings() {
    return SettingsEntity(
      isDarkModeEnabled:
          sharedPreferencesInstance.getBool(kIsDarkModeEnabledKey) ?? false,
      backupPath: sharedPreferencesInstance.getString(kBackupPath) ??
          '/storage/emulated/0/Download/Companion',
    );
  }

  @override
  Future<void> updateSettings(SettingsEntity updatedSettings) async {
    await sharedPreferencesInstance.setBool(
      kIsDarkModeEnabledKey,
      updatedSettings.isDarkModeEnabled,
    );
    await sharedPreferencesInstance.setString(
      kBackupPath,
      updatedSettings.backupPath,
    );
  }
}
