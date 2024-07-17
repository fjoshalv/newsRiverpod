// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_turnkey_test/src/features/news/domain/entities/article.dart';

class TrendsState {
  const TrendsState({
    required this.articles,
    required this.page,
    required this.hasReachedMax,
  });

  final List<Article> articles;
  final int page;
  final bool hasReachedMax;

  TrendsState copyWith({
    List<Article>? articles,
    int? page,
    bool? hasReachedMax,
  }) {
    return TrendsState(
      articles: articles ?? this.articles,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  bool operator ==(covariant TrendsState other) {
    if (identical(this, other)) return true;

    return other.articles == articles &&
        other.page == page &&
        other.hasReachedMax == hasReachedMax;
  }

  @override
  int get hashCode =>
      articles.hashCode ^ page.hashCode ^ hasReachedMax.hashCode;
}
