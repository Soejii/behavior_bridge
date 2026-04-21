import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:behavior_bridge/shared/core/constant/storage_keys.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

part 'locale_provider.g.dart';

@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    final store = ref.read(localStoreProvider);
    final tag = store.containsKey(StorageKeys.locale)
        ? (store.readJson(StorageKeys.locale)?['tag'] as String? ?? 'en')
        : 'en';
    return Locale(tag);
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final store = ref.read(localStoreProvider);
    await store.writeJson(StorageKeys.locale, {'tag': locale.languageCode});
  }
}
