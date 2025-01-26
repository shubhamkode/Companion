// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_to_agent_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$companyToAgentNotifierHash() =>
    r'e78e96093862da2c94b586ac20118ec3f99dbd97';

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

abstract class _$CompanyToAgentNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<CompanyToAgentEntity>> {
  late final String agentId;

  FutureOr<List<CompanyToAgentEntity>> build(
    String agentId,
  );
}

/// See also [CompanyToAgentNotifier].
@ProviderFor(CompanyToAgentNotifier)
const companyToAgentNotifierProvider = CompanyToAgentNotifierFamily();

/// See also [CompanyToAgentNotifier].
class CompanyToAgentNotifierFamily
    extends Family<AsyncValue<List<CompanyToAgentEntity>>> {
  /// See also [CompanyToAgentNotifier].
  const CompanyToAgentNotifierFamily();

  /// See also [CompanyToAgentNotifier].
  CompanyToAgentNotifierProvider call(
    String agentId,
  ) {
    return CompanyToAgentNotifierProvider(
      agentId,
    );
  }

  @override
  CompanyToAgentNotifierProvider getProviderOverride(
    covariant CompanyToAgentNotifierProvider provider,
  ) {
    return call(
      provider.agentId,
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
  String? get name => r'companyToAgentNotifierProvider';
}

/// See also [CompanyToAgentNotifier].
class CompanyToAgentNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CompanyToAgentNotifier,
        List<CompanyToAgentEntity>> {
  /// See also [CompanyToAgentNotifier].
  CompanyToAgentNotifierProvider(
    String agentId,
  ) : this._internal(
          () => CompanyToAgentNotifier()..agentId = agentId,
          from: companyToAgentNotifierProvider,
          name: r'companyToAgentNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$companyToAgentNotifierHash,
          dependencies: CompanyToAgentNotifierFamily._dependencies,
          allTransitiveDependencies:
              CompanyToAgentNotifierFamily._allTransitiveDependencies,
          agentId: agentId,
        );

  CompanyToAgentNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.agentId,
  }) : super.internal();

  final String agentId;

  @override
  FutureOr<List<CompanyToAgentEntity>> runNotifierBuild(
    covariant CompanyToAgentNotifier notifier,
  ) {
    return notifier.build(
      agentId,
    );
  }

  @override
  Override overrideWith(CompanyToAgentNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompanyToAgentNotifierProvider._internal(
        () => create()..agentId = agentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        agentId: agentId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CompanyToAgentNotifier,
      List<CompanyToAgentEntity>> createElement() {
    return _CompanyToAgentNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyToAgentNotifierProvider && other.agentId == agentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, agentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CompanyToAgentNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<CompanyToAgentEntity>> {
  /// The parameter `agentId` of this provider.
  String get agentId;
}

class _CompanyToAgentNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CompanyToAgentNotifier,
        List<CompanyToAgentEntity>> with CompanyToAgentNotifierRef {
  _CompanyToAgentNotifierProviderElement(super.provider);

  @override
  String get agentId => (origin as CompanyToAgentNotifierProvider).agentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
