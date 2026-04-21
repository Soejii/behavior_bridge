// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$behaviorAnalysisEngineHash() =>
    r'2c636e5151c02519372c92bde3a7e490cf380dc0';

/// See also [behaviorAnalysisEngine].
@ProviderFor(behaviorAnalysisEngine)
final behaviorAnalysisEngineProvider =
    AutoDisposeProvider<BehaviorAnalysisEngine>.internal(
  behaviorAnalysisEngine,
  name: r'behaviorAnalysisEngineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$behaviorAnalysisEngineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BehaviorAnalysisEngineRef
    = AutoDisposeProviderRef<BehaviorAnalysisEngine>;
String _$analysisHash() => r'c54d06ef1c636ec86fa6b131fe70d7238be3b3a1';

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

/// See also [analysis].
@ProviderFor(analysis)
const analysisProvider = AnalysisFamily();

/// See also [analysis].
class AnalysisFamily extends Family<AsyncValue<AnalysisResult>> {
  /// See also [analysis].
  const AnalysisFamily();

  /// See also [analysis].
  AnalysisProvider call(
    String targetId,
  ) {
    return AnalysisProvider(
      targetId,
    );
  }

  @override
  AnalysisProvider getProviderOverride(
    covariant AnalysisProvider provider,
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
  String? get name => r'analysisProvider';
}

/// See also [analysis].
class AnalysisProvider extends AutoDisposeFutureProvider<AnalysisResult> {
  /// See also [analysis].
  AnalysisProvider(
    String targetId,
  ) : this._internal(
          (ref) => analysis(
            ref as AnalysisRef,
            targetId,
          ),
          from: analysisProvider,
          name: r'analysisProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$analysisHash,
          dependencies: AnalysisFamily._dependencies,
          allTransitiveDependencies: AnalysisFamily._allTransitiveDependencies,
          targetId: targetId,
        );

  AnalysisProvider._internal(
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
    FutureOr<AnalysisResult> Function(AnalysisRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AnalysisProvider._internal(
        (ref) => create(ref as AnalysisRef),
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
  AutoDisposeFutureProviderElement<AnalysisResult> createElement() {
    return _AnalysisProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnalysisProvider && other.targetId == targetId;
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
mixin AnalysisRef on AutoDisposeFutureProviderRef<AnalysisResult> {
  /// The parameter `targetId` of this provider.
  String get targetId;
}

class _AnalysisProviderElement
    extends AutoDisposeFutureProviderElement<AnalysisResult> with AnalysisRef {
  _AnalysisProviderElement(super.provider);

  @override
  String get targetId => (origin as AnalysisProvider).targetId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
