import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:behavior_bridge/app/environment/app_config.dart';
import 'package:behavior_bridge/app/environment/build_environment.dart';
import 'package:behavior_bridge/app/theme/brand_providers.dart';
import 'package:behavior_bridge/features/seed/presentation/providers/seed_providers.dart';
import 'package:behavior_bridge/shared/core/constant/storage_keys.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/app_router.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

void main() async {
  // Eagerly reference providers before any await so DDC initializes the
  // local_store + brand_providers modules in the synchronous frame.
  // ignore: unused_local_variable
  final refs = (localStoreProvider, appConfigProvider);

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  final config = await AppConfigLoader.load(BuildEnv.client, BuildEnv.env);
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        // overrideWith defers LocalStore() construction to first watch,
        // which happens inside Flutter's build cycle (not the async frame).
        localStoreProvider.overrideWith((_) => LocalStore(prefs)),
      ],
      child: const BehaviorBridgeApp(),
    ),
  );
}

class BehaviorBridgeApp extends ConsumerWidget {
  const BehaviorBridgeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(brandPaletteProvider);
    final router = ref.watch(appRouterProvider);

    final theme = ThemeData(
      useMaterial3: true,
      extensions: <ThemeExtension<dynamic>>[palette],
      scaffoldBackgroundColor: palette.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.accent,
        surface: palette.card,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, _) => MaterialApp.router(
        title: 'BehaviorBridge',
        theme: theme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        builder: (innerCtx, child) {
          if (kDebugMode) {
            _SeedRunner.maybeRun(innerCtx);
          }
          return child ?? const SizedBox.shrink();
        },
      ),
    );
  }
}

abstract class _SeedRunner {
  static bool _done = false;

  static void maybeRun(BuildContext context) {
    if (_done) return;
    _done = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final container = ProviderScope.containerOf(context);
        final store = container.read(localStoreProvider);
        if (store.containsKey(StorageKeys.seeded)) return;
        final usecase = container.read(seedUsecaseProvider);
        await usecase.run();
        await store.writeJson(StorageKeys.seeded, {'v': 1});
      } catch (_) {}
    });
  }
}
