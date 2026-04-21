// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reinforcement_schedule_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reinforcementScheduleLocalDatasourceHash() =>
    r'ef1209ef93d72697bfbe8cb8e6fc32b25d9fddde';

/// See also [reinforcementScheduleLocalDatasource].
@ProviderFor(reinforcementScheduleLocalDatasource)
final reinforcementScheduleLocalDatasourceProvider =
    AutoDisposeProvider<ReinforcementScheduleLocalDataSource>.internal(
  reinforcementScheduleLocalDatasource,
  name: r'reinforcementScheduleLocalDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reinforcementScheduleLocalDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReinforcementScheduleLocalDatasourceRef
    = AutoDisposeProviderRef<ReinforcementScheduleLocalDataSource>;
String _$reinforcementScheduleRepositoryHash() =>
    r'13f4b2abd90ec22fc99fd2131c10c50e8df1517d';

/// See also [reinforcementScheduleRepository].
@ProviderFor(reinforcementScheduleRepository)
final reinforcementScheduleRepositoryProvider =
    AutoDisposeProvider<ReinforcementScheduleRepository>.internal(
  reinforcementScheduleRepository,
  name: r'reinforcementScheduleRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reinforcementScheduleRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReinforcementScheduleRepositoryRef
    = AutoDisposeProviderRef<ReinforcementScheduleRepository>;
String _$getSchedulesByTargetUsecaseHash() =>
    r'3e6c21d2a8b49eadff795beddd0dbec405a8502a';

/// See also [getSchedulesByTargetUsecase].
@ProviderFor(getSchedulesByTargetUsecase)
final getSchedulesByTargetUsecaseProvider =
    AutoDisposeProvider<GetSchedulesByTargetUsecase>.internal(
  getSchedulesByTargetUsecase,
  name: r'getSchedulesByTargetUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSchedulesByTargetUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetSchedulesByTargetUsecaseRef
    = AutoDisposeProviderRef<GetSchedulesByTargetUsecase>;
String _$getCurrentScheduleUsecaseHash() =>
    r'7ec9461fa91d963706297e9bcba5b17b5c97379b';

/// See also [getCurrentScheduleUsecase].
@ProviderFor(getCurrentScheduleUsecase)
final getCurrentScheduleUsecaseProvider =
    AutoDisposeProvider<GetCurrentScheduleUsecase>.internal(
  getCurrentScheduleUsecase,
  name: r'getCurrentScheduleUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentScheduleUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetCurrentScheduleUsecaseRef
    = AutoDisposeProviderRef<GetCurrentScheduleUsecase>;
String _$upsertScheduleUsecaseHash() =>
    r'b6112eccf607844a5c30f9e35432dc7802473a1d';

/// See also [upsertScheduleUsecase].
@ProviderFor(upsertScheduleUsecase)
final upsertScheduleUsecaseProvider =
    AutoDisposeProvider<UpsertScheduleUsecase>.internal(
  upsertScheduleUsecase,
  name: r'upsertScheduleUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upsertScheduleUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpsertScheduleUsecaseRef
    = AutoDisposeProviderRef<UpsertScheduleUsecase>;
String _$schedulesByTargetHash() => r'd35ded75a7ef4350cb605c71fabac1300f5b8c1c';

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

/// See also [schedulesByTarget].
@ProviderFor(schedulesByTarget)
const schedulesByTargetProvider = SchedulesByTargetFamily();

/// See also [schedulesByTarget].
class SchedulesByTargetFamily
    extends Family<AsyncValue<List<ReinforcementScheduleEntity>>> {
  /// See also [schedulesByTarget].
  const SchedulesByTargetFamily();

  /// See also [schedulesByTarget].
  SchedulesByTargetProvider call(
    String targetId,
  ) {
    return SchedulesByTargetProvider(
      targetId,
    );
  }

  @override
  SchedulesByTargetProvider getProviderOverride(
    covariant SchedulesByTargetProvider provider,
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
  String? get name => r'schedulesByTargetProvider';
}

/// See also [schedulesByTarget].
class SchedulesByTargetProvider
    extends AutoDisposeFutureProvider<List<ReinforcementScheduleEntity>> {
  /// See also [schedulesByTarget].
  SchedulesByTargetProvider(
    String targetId,
  ) : this._internal(
          (ref) => schedulesByTarget(
            ref as SchedulesByTargetRef,
            targetId,
          ),
          from: schedulesByTargetProvider,
          name: r'schedulesByTargetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$schedulesByTargetHash,
          dependencies: SchedulesByTargetFamily._dependencies,
          allTransitiveDependencies:
              SchedulesByTargetFamily._allTransitiveDependencies,
          targetId: targetId,
        );

  SchedulesByTargetProvider._internal(
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
    FutureOr<List<ReinforcementScheduleEntity>> Function(
            SchedulesByTargetRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SchedulesByTargetProvider._internal(
        (ref) => create(ref as SchedulesByTargetRef),
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
  AutoDisposeFutureProviderElement<List<ReinforcementScheduleEntity>>
      createElement() {
    return _SchedulesByTargetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SchedulesByTargetProvider && other.targetId == targetId;
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
mixin SchedulesByTargetRef
    on AutoDisposeFutureProviderRef<List<ReinforcementScheduleEntity>> {
  /// The parameter `targetId` of this provider.
  String get targetId;
}

class _SchedulesByTargetProviderElement
    extends AutoDisposeFutureProviderElement<List<ReinforcementScheduleEntity>>
    with SchedulesByTargetRef {
  _SchedulesByTargetProviderElement(super.provider);

  @override
  String get targetId => (origin as SchedulesByTargetProvider).targetId;
}

String _$currentScheduleHash() => r'a9dfeeab39541630c4a6b8a28803796c34cb6eda';

/// See also [currentSchedule].
@ProviderFor(currentSchedule)
const currentScheduleProvider = CurrentScheduleFamily();

/// See also [currentSchedule].
class CurrentScheduleFamily
    extends Family<AsyncValue<ReinforcementScheduleEntity?>> {
  /// See also [currentSchedule].
  const CurrentScheduleFamily();

  /// See also [currentSchedule].
  CurrentScheduleProvider call(
    String targetId,
  ) {
    return CurrentScheduleProvider(
      targetId,
    );
  }

  @override
  CurrentScheduleProvider getProviderOverride(
    covariant CurrentScheduleProvider provider,
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
  String? get name => r'currentScheduleProvider';
}

/// See also [currentSchedule].
class CurrentScheduleProvider
    extends AutoDisposeFutureProvider<ReinforcementScheduleEntity?> {
  /// See also [currentSchedule].
  CurrentScheduleProvider(
    String targetId,
  ) : this._internal(
          (ref) => currentSchedule(
            ref as CurrentScheduleRef,
            targetId,
          ),
          from: currentScheduleProvider,
          name: r'currentScheduleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentScheduleHash,
          dependencies: CurrentScheduleFamily._dependencies,
          allTransitiveDependencies:
              CurrentScheduleFamily._allTransitiveDependencies,
          targetId: targetId,
        );

  CurrentScheduleProvider._internal(
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
    FutureOr<ReinforcementScheduleEntity?> Function(CurrentScheduleRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentScheduleProvider._internal(
        (ref) => create(ref as CurrentScheduleRef),
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
  AutoDisposeFutureProviderElement<ReinforcementScheduleEntity?>
      createElement() {
    return _CurrentScheduleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentScheduleProvider && other.targetId == targetId;
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
mixin CurrentScheduleRef
    on AutoDisposeFutureProviderRef<ReinforcementScheduleEntity?> {
  /// The parameter `targetId` of this provider.
  String get targetId;
}

class _CurrentScheduleProviderElement
    extends AutoDisposeFutureProviderElement<ReinforcementScheduleEntity?>
    with CurrentScheduleRef {
  _CurrentScheduleProviderElement(super.provider);

  @override
  String get targetId => (origin as CurrentScheduleProvider).targetId;
}

String _$reinforcementScheduleControllerHash() =>
    r'33c411a22a0cabd91264b4763ef6206145f72624';

/// See also [ReinforcementScheduleController].
@ProviderFor(ReinforcementScheduleController)
final reinforcementScheduleControllerProvider =
    AsyncNotifierProvider<ReinforcementScheduleController, void>.internal(
  ReinforcementScheduleController.new,
  name: r'reinforcementScheduleControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reinforcementScheduleControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReinforcementScheduleController = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
