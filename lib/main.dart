import 'package:companion/src/core/pods/shared_prefs_pod.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/core/widgets/with_screen_util.dart';
import 'package:companion/src/features/companies/models/company.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CompanyAdapter());
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(PimAdapter());

  await Hive.openBox<Company>("companies");
  await Hive.openBox<Contact>("contacts");
  await Hive.openBox<Pim>("pims");

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsPodProvider.overrideWithValue(prefs),
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

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: context.colors.surfaceContainer,
      ),
    );

    return WithScreenUtil(
      child: MaterialApp.router(
        theme: ThemeData(useMaterial3: true).copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router.config(),
      ),
    );
  }
}
