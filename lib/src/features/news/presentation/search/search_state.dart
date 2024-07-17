// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_riverpod/src/features/news/domain/entities/article.dart';

class SearchState {
  const SearchState({
    this.articles = const [],
    required this.query,
    required this.page,
    required this.hasReachedMax,
  });

  final List<Article> articles;
  final String query;
  final int page;
  final bool hasReachedMax;

  factory SearchState.initial() {
    return const SearchState(
      articles: [],
      query: '',
      page: 1,
      hasReachedMax: false,
    );
  }

  SearchState copyWith({
    List<Article>? articles,
    String? query,
    int? page,
    bool? hasReachedMax,
  }) {
    return SearchState(
      articles: articles ?? this.articles,
      query: query ?? this.query,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
