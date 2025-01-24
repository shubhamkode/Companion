// ignore_for_file: public_member_api_docs, sort_constructors_first
class SettingsEntity {
  final bool isDarkModeEnabled;
  final String backupPath;

  SettingsEntity({
    required this.isDarkModeEnabled,
    required this.backupPath,
  });

  @override
  String toString() =>
      'SettingsEntity(isDarkModeEnabled: $isDarkModeEnabled, backupPath: $backupPath)';

  SettingsEntity copyWith({
    bool? isDarkModeEnabled,
    String? backupPath,
  }) {
    return SettingsEntity(
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      backupPath: backupPath ?? this.backupPath,
    );
  }
}
