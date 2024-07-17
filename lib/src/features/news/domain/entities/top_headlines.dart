// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:flutter_turnkey_test/src/features/news/data/models/top_headlines_response.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/article.dart';

class TopHeadlines {
  const TopHeadlines({
    required this.totalResults,
    required this.articles,
  });

  final int totalResults;
  final List<Article> articles;

  factory TopHeadlines.fromResponse(TopHeadlinesResponse map) {
    return TopHeadlines(
      totalResults: map.totalResults,
      articles: map.articles.map((x) => Article.fromResponse(x)).toList(),
    );
  }

  @override
  bool operator ==(covariant TopHeadlines other) {
    if (identical(this, other)) return true;

    return other.totalResults == totalResults &&
        listEquals(other.articles, articles);
  }

  @override
  int get hashCode => totalResults.hashCode ^ articles.hashCode;

  @override
  String toString() =>
      'TopHeadlines(totalResults: $totalResults, articles: $articles)';

  TopHeadlines copyWith({
    int? totalResults,
    List<Article>? articles,
  }) {
    return TopHeadlines(
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }
}
