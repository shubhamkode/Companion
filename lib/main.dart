import 'package:companion/src/core/app/app.dart';
import 'package:companion/src/core/services/service_locator.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefsInstance = await SharedPreferences.getInstance();

  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefsInstance)
      ],
      child: CompanionApp(),
    ),
  );
}
