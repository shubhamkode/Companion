import 'package:companion/src/features/settings/models/settings_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  final Box<SettingsModel> _box;

  SettingsRepository(this._box);

  SettingsModel? getSettings() {
    return _box.get(0);
  }

  Future<void> updateSettings(SettingsModel updatedSettigs) async {
    return _box.put(0, updatedSettigs);
  }
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  final box = Hive.box<SettingsModel>("settings");

  return SettingsRepository(box);
}
