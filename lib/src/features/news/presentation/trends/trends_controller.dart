import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_turnkey_test/src/features/news/data/news_remote_repository.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/news.dart';
import 'package:flutter_turnkey_test/src/features/news/presentation/trends/trends_state.dart';
import 'package:flutter_turnkey_test/src/shared/domain/params/pagination_params.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trends_controller.g.dart';

@riverpod
class TrendsController extends _$TrendsController {
  @override
  FutureOr<TrendsState> build() async {
    final topHeadlines = await _getInitialTopHeadlines();

    return TrendsState(
      articles: topHeadlines.articles,
      page: 1,
      hasReachedMax: topHeadlines.articles.isEmpty,
    );
  }

  Future<News> _getInitialTopHeadlines() async {
    final newsRemoteRepository = ref.read(newsRemoteRepositoryProvider);
    const params = PaginationParams(page: 1);
    final topHeadlines = await newsRemoteRepository.getTopHeadlines(params);
    return topHeadlines;
  }

  Future<void> loadMoreHeadlines() async {
    AsyncData<TrendsState>? oldState;

    if (state is AsyncData<TrendsState>) {
      oldState = state as AsyncData<TrendsState>;
      if (oldState.value.hasReachedMax) return;
    }

    final nextPage = (oldState?.value.page ?? 0) + 1;
    final params = PaginationParams(page: nextPage);

    state = await AsyncValue.guard(
      () async {
        final topHeadlines = await ref
            .read(newsRemoteRepositoryProvider)
            .getTopHeadlines(params);
        return TrendsState(
          articles: [...?oldState?.value.articles, ...topHeadlines.articles],
          page: nextPage,
          hasReachedMax: topHeadlines.articles.isEmpty,
        );
      },
    );
  }
}
