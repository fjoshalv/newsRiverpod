import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_riverpod/src/features/news/data/news_remote_repository.dart';
import 'package:news_riverpod/src/features/news/domain/entities/article.dart';
import 'package:news_riverpod/src/shared/domain/params/network_params.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_headlines_service.g.dart';

class TopHeadlinesService {
  TopHeadlinesService({
    required this.ref,
  }) {
    Timer.periodic(const Duration(minutes: 1), (_) {
      print('Checking if there is a new top headline');
      checkIfThereIsANewTopHeadline();
    });
  }
  final Ref ref;

  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  Article? _mostRecentGottenArticle;

  Article? get mostRecentGottenArticle => _mostRecentGottenArticle;
  set mostRecentGottenArticle(Article? article) {
    _controller.add(false);
    _mostRecentGottenArticle = article;
  }

  Stream<bool> get stream => _controller.stream;

  Future<Article> getMostRecentTopHeadline() {
    final repository = ref.read(newsRemoteRepositoryProvider);
    return repository
        .getTopHeadlines(
          const NetworkParams(page: 1, pageSize: 1),
        )
        .then((news) => news.articles.first);
  }

  Future<void> checkIfThereIsANewTopHeadline() async {
    final mostRecentArticle = await getMostRecentTopHeadline();
    if (mostRecentGottenArticle != mostRecentArticle) {
      _controller.add(true);
    }
  }
}

@riverpod
TopHeadlinesService topHeadlinesService(TopHeadlinesServiceRef ref) {
  return TopHeadlinesService(ref: ref);
}

@riverpod
Stream<bool> shouldRefreshTopHeadlines(ShouldRefreshTopHeadlinesRef ref) {
  return ref.watch(topHeadlinesServiceProvider).stream;
}
