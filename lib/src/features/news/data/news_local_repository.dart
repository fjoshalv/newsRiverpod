// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_riverpod/src/features/news/domain/entities/article.dart';
import 'package:news_riverpod/src/shared/data/data_sources/local_storage_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';

part 'news_local_repository.g.dart';

class NewsLocalRepository {
  const NewsLocalRepository({
    required this.localStorageManager,
  });

  static final StoreRef<String, Map<String, dynamic>> store =
      stringMapStoreFactory.store('news');

  final LocalStorageManager localStorageManager;

  Stream<List<Article>> watchArticles() {
    return localStorageManager
        .watchRecordsInCustomStore(
      store: store,
      finder: Finder(
        sortOrders: [
          SortOrder('publishedAt', false),
        ],
      ),
    )
        .map((records) {
      return records.map((record) {
        return Article.fromMap(record);
      }).toList();
    });
  }

  Future<Article?> getArticle(String uuid) async {
    final record =
        await localStorageManager.getRecordInCustomStore<Map<String, dynamic>>(
      key: uuid,
      store: store,
    );
    if (record == null) return null;
    return Article.fromMap(record);
  }

  Future<void> saveArticle(Article article) async {
    await localStorageManager.saveInCustomStore(
      article.toMap(),
      store: store,
      key: article.id,
    );
  }

  Future<void> deleteArticle(String uuid) async {
    await localStorageManager.deleteInCustomStore(
      uuid,
      store: store,
    );
  }
}

@riverpod
NewsLocalRepository newsLocalRepository(NewsLocalRepositoryRef ref) {
  return NewsLocalRepository(
    localStorageManager: ref.watch(localStorageManagerProvider),
  );
}

@riverpod
Stream<List<Article>> bookmarkedArticles(BookmarkedArticlesRef ref) {
  final newsLocalRepository = ref.watch(newsLocalRepositoryProvider);
  return newsLocalRepository.watchArticles();
}

@riverpod
FutureOr<Article?> getArticleById(GetArticleByIdRef ref, String id) {
  return ref.read(newsLocalRepositoryProvider).getArticle(id);
}
