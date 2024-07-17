import 'dart:async';

import 'package:news_riverpod/src/features/news/data/news_remote_repository.dart';
import 'package:news_riverpod/src/features/news/presentation/search/search_state.dart';
import 'package:news_riverpod/src/shared/domain/params/network_params.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_controller.g.dart';

@riverpod
class SearchController extends _$SearchController {
  @override
  FutureOr<SearchState> build() {
    return SearchState.initial();
  }

  Timer? _debouncer;

  void onSearch(String query) {
    state = const AsyncLoading();
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(seconds: 3), () {
      _debouncer = null;
      if (query.isEmpty) {
        state = AsyncData(SearchState.initial());
        return;
      }
      loadNewsFor(query: query);
    });
  }

  Future<void> loadNewsFor({
    required String query,
  }) async {
    AsyncData<SearchState>? oldState;

    if (state is AsyncData<SearchState>) {
      oldState = state as AsyncData<SearchState>;
      if (oldState.value.hasReachedMax) return;
    }

    final nextPage = (oldState?.value.page ?? 0) + 1;
    final params = NetworkParams(page: nextPage, query: query);

    state = await AsyncValue.guard(
      () async {
        final topHeadlines =
            await ref.read(newsRemoteRepositoryProvider).getEverything(params);
        return SearchState(
          query: query,
          articles: [...?oldState?.value.articles, ...topHeadlines.articles],
          page: nextPage,
          hasReachedMax: topHeadlines.articles.isEmpty,
        );
      },
    );
  }
}
