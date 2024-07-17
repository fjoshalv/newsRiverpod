// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_local_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newsLocalRepositoryHash() =>
    r'2be298c44d0f6c80674805c7813f96ca8a213a05';

/// See also [newsLocalRepository].
@ProviderFor(newsLocalRepository)
final newsLocalRepositoryProvider =
    AutoDisposeProvider<NewsLocalRepository>.internal(
  newsLocalRepository,
  name: r'newsLocalRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newsLocalRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NewsLocalRepositoryRef = AutoDisposeProviderRef<NewsLocalRepository>;
String _$bookmarkedArticlesHash() =>
    r'63f36964a1c14f4ca01c5f18914129e67527527f';

/// See also [bookmarkedArticles].
@ProviderFor(bookmarkedArticles)
final bookmarkedArticlesProvider =
    AutoDisposeStreamProvider<List<Article>>.internal(
  bookmarkedArticles,
  name: r'bookmarkedArticlesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookmarkedArticlesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BookmarkedArticlesRef = AutoDisposeStreamProviderRef<List<Article>>;
String _$getArticleByIdHash() => r'7d8e4902ce51dc5f4a543bbc6aa45af81da6739b';

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

/// See also [getArticleById].
@ProviderFor(getArticleById)
const getArticleByIdProvider = GetArticleByIdFamily();

/// See also [getArticleById].
class GetArticleByIdFamily extends Family<AsyncValue<Article?>> {
  /// See also [getArticleById].
  const GetArticleByIdFamily();

  /// See also [getArticleById].
  GetArticleByIdProvider call(
    String id,
  ) {
    return GetArticleByIdProvider(
      id,
    );
  }

  @override
  GetArticleByIdProvider getProviderOverride(
    covariant GetArticleByIdProvider provider,
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
  String? get name => r'getArticleByIdProvider';
}

/// See also [getArticleById].
class GetArticleByIdProvider extends AutoDisposeFutureProvider<Article?> {
  /// See also [getArticleById].
  GetArticleByIdProvider(
    String id,
  ) : this._internal(
          (ref) => getArticleById(
            ref as GetArticleByIdRef,
            id,
          ),
          from: getArticleByIdProvider,
          name: r'getArticleByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getArticleByIdHash,
          dependencies: GetArticleByIdFamily._dependencies,
          allTransitiveDependencies:
              GetArticleByIdFamily._allTransitiveDependencies,
          id: id,
        );

  GetArticleByIdProvider._internal(
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
    FutureOr<Article?> Function(GetArticleByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetArticleByIdProvider._internal(
        (ref) => create(ref as GetArticleByIdRef),
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
  AutoDisposeFutureProviderElement<Article?> createElement() {
    return _GetArticleByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetArticleByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetArticleByIdRef on AutoDisposeFutureProviderRef<Article?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GetArticleByIdProviderElement
    extends AutoDisposeFutureProviderElement<Article?> with GetArticleByIdRef {
  _GetArticleByIdProviderElement(super.provider);

  @override
  String get id => (origin as GetArticleByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
