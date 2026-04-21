import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:behavior_bridge/app/environment/app_config.dart';
import 'package:behavior_bridge/app/theme/brand_palette.dart';

part 'brand_providers.g.dart';

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) =>
    throw UnimplementedError('appConfigProvider must be overridden in main()');

@riverpod
BrandPalette brandPalette(Ref ref) {
  final cfg = ref.watch(appConfigProvider);
  return cfg.colors.isEmpty
      ? BrandPalette.defaults()
      : BrandPalette.fromConfig(cfg.colors);
}
