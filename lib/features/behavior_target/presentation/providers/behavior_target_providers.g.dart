// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'behavior_target_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$behaviorTargetLocalDatasourceHash() =>
    r'ff9ce1543232d8d0b0056ddf8d17ecbf84045396';

/// See also [behaviorTargetLocalDatasource].
@ProviderFor(behaviorTargetLocalDatasource)
final behaviorTargetLocalDatasourceProvider =
    AutoDisposeProvider<BehaviorTargetLocalDataSource>.internal(
  behaviorTargetLocalDatasource,
  name: r'behaviorTargetLocalDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$behaviorTargetLocalDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BehaviorTargetLocalDatasourceRef
    = AutoDisposeProviderRef<BehaviorTargetLocalDataSource>;
String _$behaviorTargetRepositoryHash() =>
    r'eba13580bc302c7257bd743bd1aa3308f0ef7ad6';

/// See also [behaviorTargetRepository].
@ProviderFor(behaviorTargetRepository)
final behaviorTargetRepositoryProvider =
    AutoDisposeProvider<BehaviorTargetRepository>.internal(
  behaviorTargetRepository,
  name: r'behaviorTargetRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$behaviorTargetRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BehaviorTargetRepositoryRef
    = AutoDisposeProviderRef<BehaviorTargetRepository>;
String _$getTargetsBySubjectUsecaseHash() =>
    r'e4ea611cb68a4ceb725787f72dd8e5fd1fc798ad';

/// See also [getTargetsBySubjectUsecase].
@ProviderFor(getTargetsBySubjectUsecase)
final getTargetsBySubjectUsecaseProvider =
    AutoDisposeProvider<GetTargetsBySubjectUsecase>.internal(
  getTargetsBySubjectUsecase,
  name: r'getTargetsBySubjectUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTargetsBySubjectUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetTargetsBySubjectUsecaseRef
    = AutoDisposeProviderRef<GetTargetsBySubjectUsecase>;
String _$getTargetByIdUsecaseHash() =>
    r'b5e324155cedc867bcbb7a3cde8d656d1ab846b4';

/// See also [getTargetByIdUsecase].
@ProviderFor(getTargetByIdUsecase)
final getTargetByIdUsecaseProvider =
    AutoDisposeProvider<GetTargetByIdUsecase>.internal(
  getTargetByIdUsecase,
  name: r'getTargetByIdUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTargetByIdUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetTargetByIdUsecaseRef = AutoDisposeProviderRef<GetTargetByIdUsecase>;
String _$upsertTargetUsecaseHash() =>
    r'71b9862c0aba6d3e93978b850c689a5881f677b1';

/// See also [upsertTargetUsecase].
@ProviderFor(upsertTargetUsecase)
final upsertTargetUsecaseProvider =
    AutoDisposeProvider<UpsertTargetUsecase>.internal(
  upsertTargetUsecase,
  name: r'upsertTargetUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upsertTargetUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpsertTargetUsecaseRef = AutoDisposeProviderRef<UpsertTargetUsecase>;
String _$deleteTargetUsecaseHash() =>
    r'0216c3ae98951800f17380cff2ac26ccd76b0f22';

/// See also [deleteTargetUsecase].
@ProviderFor(deleteTargetUsecase)
final deleteTargetUsecaseProvider =
    AutoDisposeProvider<DeleteTargetUsecase>.internal(
  deleteTargetUsecase,
  name: r'deleteTargetUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteTargetUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeleteTargetUsecaseRef = AutoDisposeProviderRef<DeleteTargetUsecase>;
String _$targetsBySubjectHash() => r'44df978135701cc3df12e0de8c7e1b2c92df30d8';

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

/// See also [targetsBySubject].
@ProviderFor(targetsBySubject)
const targetsBySubjectProvider = TargetsBySubjectFamily();

/// See also [targetsBySubject].
class TargetsBySubjectFamily
    extends Family<AsyncValue<List<BehaviorTargetEntity>>> {
  /// See also [targetsBySubject].
  const TargetsBySubjectFamily();

  /// See also [targetsBySubject].
  TargetsBySubjectProvider call(
    String subjectId,
  ) {
    return TargetsBySubjectProvider(
      subjectId,
    );
  }

  @override
  TargetsBySubjectProvider getProviderOverride(
    covariant TargetsBySubjectProvider provider,
  ) {
    return call(
      provider.subjectId,
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
  String? get name => r'targetsBySubjectProvider';
}

/// See also [targetsBySubject].
class TargetsBySubjectProvider
    extends AutoDisposeFutureProvider<List<BehaviorTargetEntity>> {
  /// See also [targetsBySubject].
  TargetsBySubjectProvider(
    String subjectId,
  ) : this._internal(
          (ref) => targetsBySubject(
            ref as TargetsBySubjectRef,
            subjectId,
          ),
          from: targetsBySubjectProvider,
          name: r'targetsBySubjectProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$targetsBySubjectHash,
          dependencies: TargetsBySubjectFamily._dependencies,
          allTransitiveDependencies:
              TargetsBySubjectFamily._allTransitiveDependencies,
          subjectId: subjectId,
        );

  TargetsBySubjectProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.subjectId,
  }) : super.internal();

  final String subjectId;

  @override
  Override overrideWith(
    FutureOr<List<BehaviorTargetEntity>> Function(TargetsBySubjectRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TargetsBySubjectProvider._internal(
        (ref) => create(ref as TargetsBySubjectRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        subjectId: subjectId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<BehaviorTargetEntity>> createElement() {
    return _TargetsBySubjectProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TargetsBySubjectProvider && other.subjectId == subjectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subjectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TargetsBySubjectRef
    on AutoDisposeFutureProviderRef<List<BehaviorTargetEntity>> {
  /// The parameter `subjectId` of this provider.
  String get subjectId;
}

class _TargetsBySubjectProviderElement
    extends AutoDisposeFutureProviderElement<List<BehaviorTargetEntity>>
    with TargetsBySubjectRef {
  _TargetsBySubjectProviderElement(super.provider);

  @override
  String get subjectId => (origin as TargetsBySubjectProvider).subjectId;
}

String _$targetByIdHash() => r'c51f613d00cf4bc45237e6d8c665e951e3040541';

/// See also [targetById].
@ProviderFor(targetById)
const targetByIdProvider = TargetByIdFamily();

/// See also [targetById].
class TargetByIdFamily extends Family<AsyncValue<BehaviorTargetEntity?>> {
  /// See also [targetById].
  const TargetByIdFamily();

  /// See also [targetById].
  TargetByIdProvider call(
    String id,
  ) {
    return TargetByIdProvider(
      id,
    );
  }

  @override
  TargetByIdProvider getProviderOverride(
    covariant TargetByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'targetByIdProvider';
}

/// See also [targetById].
class TargetByIdProvider
    extends AutoDisposeFutureProvider<BehaviorTargetEntity?> {
  /// See also [targetById].
  TargetByIdProvider(
    String id,
  ) : this._internal(
          (ref) => targetById(
            ref as TargetByIdRef,
            id,
          ),
          from: targetByIdProvider,
          name: r'targetByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$targetByIdHash,
          dependencies: TargetByIdFamily._dependencies,
          allTransitiveDependencies:
              TargetByIdFamily._allTransitiveDependencies,
          id: id,
        );

  TargetByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<BehaviorTargetEntity?> Function(TargetByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TargetByIdProvider._internal(
        (ref) => create(ref as TargetByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BehaviorTargetEntity?> createElement() {
    return _TargetByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TargetByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TargetByIdRef on AutoDisposeFutureProviderRef<BehaviorTargetEntity?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TargetByIdProviderElement
    extends AutoDisposeFutureProviderElement<BehaviorTargetEntity?>
    with TargetByIdRef {
  _TargetByIdProviderElement(super.provider);

  @override
  String get id => (origin as TargetByIdProvider).id;
}

String _$behaviorTargetControllerHash() =>
    r'c272507dfb17bed61a2367c983ad14cb8769b3ba';

/// See also [BehaviorTargetController].
@ProviderFor(BehaviorTargetController)
final behaviorTargetControllerProvider =
    AsyncNotifierProvider<BehaviorTargetController, void>.internal(
  BehaviorTargetController.new,
  name: r'behaviorTargetControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$behaviorTargetControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BehaviorTargetController = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
