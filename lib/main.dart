import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/core/widgets/with_screen_util.dart';
import 'package:companion/src/features/settings/models/settings_model.dart';
import 'package:companion/src/features/settings/pods/settings_pod.dart';
import 'package:companion/src/hive/hive_pod.dart';
import 'package:companion/src/hive/hive_registrar.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive
    ..initFlutter()
    ..registerAdapters();

  await Hive.openBox<SettingsModel>(
    "settings",
    path: (await getApplicationDocumentsDirectory()).path,
  );

  final collection = await BoxCollection.open(
    'myDb',
    {"companies", "contacts", "pims", "company_to_contact"},
    path: (await getApplicationDocumentsDirectory()).path,
  );

  runApp(
    ProviderScope(
      overrides: [
        hivePodProvider.overrideWithValue(collection),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerPodProvider);
    final isDarkModeEnabled = ref.watch(
      settingsPodProvider.select((pod) => pod.isDarkModeEnabled),
    );

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: isDarkModeEnabled
            ? ThemeData.dark().colorScheme.surfaceContainer
            : ThemeData.light().colorScheme.surfaceContainer,
      ),
      child: WithScreenUtil(
        child: MaterialApp.router(
          theme: ThemeData(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routerConfig: router.config(),
        ),
      ),
    );
  }
}
