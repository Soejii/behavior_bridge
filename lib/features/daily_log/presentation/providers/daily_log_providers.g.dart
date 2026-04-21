// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_log_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyLogLocalDatasourceHash() =>
    r'7d5b5d77f746d75235a1657fbc80e4a004f81acb';

/// See also [dailyLogLocalDatasource].
@ProviderFor(dailyLogLocalDatasource)
final dailyLogLocalDatasourceProvider =
    AutoDisposeProvider<DailyLogLocalDataSource>.internal(
  dailyLogLocalDatasource,
  name: r'dailyLogLocalDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyLogLocalDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DailyLogLocalDatasourceRef
    = AutoDisposeProviderRef<DailyLogLocalDataSource>;
String _$dailyLogRepositoryHash() =>
    r'343f34dd07b1889d630dc437c9da6c34901d6b3f';

/// See also [dailyLogRepository].
@ProviderFor(dailyLogRepository)
final dailyLogRepositoryProvider =
    AutoDisposeProvider<DailyLogRepository>.internal(
  dailyLogRepository,
  name: r'dailyLogRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyLogRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DailyLogRepositoryRef = AutoDisposeProviderRef<DailyLogRepository>;
String _$getLogsByTargetUsecaseHash() =>
    r'1c6298862b204d984c31e01db73c26fe02400137';

/// See also [getLogsByTargetUsecase].
@ProviderFor(getLogsByTargetUsecase)
final getLogsByTargetUsecaseProvider =
    AutoDisposeProvider<GetLogsByTargetUsecase>.internal(
  getLogsByTargetUsecase,
  name: r'getLogsByTargetUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLogsByTargetUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetLogsByTargetUsecaseRef
    = AutoDisposeProviderRef<GetLogsByTargetUsecase>;
String _$getLogForDateUsecaseHash() =>
    r'50269952f2e9cb6b1332599761b8efefc0d62924';

/// See also [getLogForDateUsecase].
@ProviderFor(getLogForDateUsecase)
final getLogForDateUsecaseProvider =
    AutoDisposeProvider<GetLogForDateUsecase>.internal(
  getLogForDateUsecase,
  name: r'getLogForDateUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLogForDateUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetLogForDateUsecaseRef = AutoDisposeProviderRef<GetLogForDateUsecase>;
String _$upsertLogUsecaseHash() => r'6146973cb2ea94f7954f718794f87fe0ec5a6639';

/// See also [upsertLogUsecase].
@ProviderFor(upsertLogUsecase)
final upsertLogUsecaseProvider = AutoDisposeProvider<UpsertLogUsecase>.internal(
  upsertLogUsecase,
  name: r'upsertLogUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upsertLogUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpsertLogUsecaseRef = AutoDisposeProviderRef<UpsertLogUsecase>;
String _$logsByTargetHash() => r'92ff56233312836bcfc46480d2a9c8475e109ec7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [logsByTarget].
@ProviderFor(logsByTarget)
const logsByTargetProvider = LogsByTargetFamily();

/// See also [logsByTarget].
class LogsByTargetFamily extends Family<AsyncValue<List<DailyLogEntity>>> {
  /// See also [logsByTarget].
  const LogsByTargetFamily();

  /// See also [logsByTarget].
  LogsByTargetProvider call(
    String targetId,
  ) {
    return LogsByTargetProvider(
      targetId,
    );
  }

  @override
  LogsByTargetProvider getProviderOverride(
    covariant LogsByTargetProvider provider,
  ) {
    return call(
      provider.targetId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'logsByTargetProvider';
}

/// See also [logsByTarget].
class LogsByTargetProvider
    extends AutoDisposeFutureProvider<List<DailyLogEntity>> {
  /// See also [logsByTarget].
  LogsByTargetProvider(
    String targetId,
  ) : this._internal(
          (ref) => logsByTarget(
            ref as LogsByTargetRef,
            targetId,
          ),
          from: logsByTargetProvider,
          name: r'logsByTargetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$logsByTargetHash,
          dependencies: LogsByTargetFamily._dependencies,
          allTransitiveDependencies:
              LogsByTargetFamily._allTransitiveDependencies,
          targetId: targetId,
        );

  LogsByTargetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.targetId,
  }) : super.internal();

  final String targetId;

  @override
  Override overrideWith(
    FutureOr<List<DailyLogEntity>> Function(LogsByTargetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LogsByTargetProvider._internal(
        (ref) => create(ref as LogsByTargetRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        targetId: targetId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DailyLogEntity>> createElement() {
    return _LogsByTargetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LogsByTargetProvider && other.targetId == targetId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, targetId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LogsByTargetRef on AutoDisposeFutureProviderRef<List<DailyLogEntity>> {
  /// The parameter `targetId` of this provider.
  String get targetId;
}

class _LogsByTargetProviderElement
    extends AutoDisposeFutureProviderElement<List<DailyLogEntity>>
    with LogsByTargetRef {
  _LogsByTargetProviderElement(super.provider);

  @override
  String get targetId => (origin as LogsByTargetProvider).targetId;
}

String _$logForTargetTodayHash() => r'09b646363754f8e081710e34cc20100ccf029f19';

/// See also [logForTargetToday].
@ProviderFor(logForTargetToday)
const logForTargetTodayProvider = LogForTargetTodayFamily();

/// See also [logForTargetToday].
class LogForTargetTodayFamily extends Family<AsyncValue<DailyLogEntity?>> {
  /// See also [logForTargetToday].
  const LogForTargetTodayFamily();

  /// See also [logForTargetToday].
  LogForTargetTodayProvider call(
    String targetId,
  ) {
    return LogForTargetTodayProvider(
      targetId,
    );
  }

  @override
  LogForTargetTodayProvider getProviderOverride(
    covariant LogForTargetTodayProvider provider,
  ) {
    return call(
      provider.targetId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'logForTargetTodayProvider';
}

/// See also [logForTargetToday].
class LogForTargetTodayProvider
    extends AutoDisposeFutureProvider<DailyLogEntity?> {
  /// See also [logForTargetToday].
  LogForTargetTodayProvider(
    String targetId,
  ) : this._internal(
          (ref) => logForTargetToday(
            ref as LogForTargetTodayRef,
            targetId,
          ),
          from: logForTargetTodayProvider,
          name: r'logForTargetTodayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$logForTargetTodayHash,
          dependencies: LogForTargetTodayFamily._dependencies,
          allTransitiveDependencies:
              LogForTargetTodayFamily._allTransitiveDependencies,
          targetId: targetId,
        );

  LogForTargetTodayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.targetId,
  }) : super.internal();

  final String targetId;

  @override
  Override overrideWith(
    FutureOr<DailyLogEntity?> Function(LogForTargetTodayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LogForTargetTodayProvider._internal(
        (ref) => create(ref as LogForTargetTodayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        targetId: targetId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DailyLogEntity?> createElement() {
    return _LogForTargetTodayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LogForTargetTodayProvider && other.targetId == targetId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, targetId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LogForTargetTodayRef on AutoDisposeFutureProviderRef<DailyLogEntity?> {
  /// The parameter `targetId` of this provider.
  String get targetId;
}

class _LogForTargetTodayProviderElement
    extends AutoDisposeFutureProviderElement<DailyLogEntity?>
    with LogForTargetTodayRef {
  _LogForTargetTodayProviderElement(super.provider);

  @override
  String get targetId => (origin as LogForTargetTodayProvider).targetId;
}

String _$dailyLogControllerHash() =>
    r'81dc7a38c24c8cbc17cba875fb5d92726e6a6499';

/// See also [DailyLogController].
@ProviderFor(DailyLogController)
final dailyLogControllerProvider =
    AsyncNotifierProvider<DailyLogController, void>.internal(
  DailyLogController.new,
  name: r'dailyLogControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyLogControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DailyLogController = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
