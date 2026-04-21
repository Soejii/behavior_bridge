import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

    return MaterialApp.router(
      title: 'BehaviorBridge',
      theme: theme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (innerCtx, child) {
        _SeedRunner.maybeRun(innerCtx);
        
        Widget content = child ?? const SizedBox.shrink();

        final mediaQueryData = MediaQuery.of(innerCtx);
        final isWide = kIsWeb && mediaQueryData.size.width > 480;

        if (isWide) {
          return Scaffold(
            backgroundColor: const Color(0xFFE5E9F0), // A soft gray background
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRect(child: content),
                ),
              ),
            ),
          );
        }

        return content;
      },
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
      } catch (e) {
        debugPrint('[SeedRunner] error: $e');
      }
    });
  }
}
