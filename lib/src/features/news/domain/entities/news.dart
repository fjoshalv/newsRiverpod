// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:news_riverpod/src/features/news/data/models/news_response.dart';
import 'package:news_riverpod/src/features/news/domain/entities/article.dart';

class News {
  const News({
    required this.totalResults,
    required this.articles,
  });

  final int totalResults;
  final List<Article> articles;

  factory News.fromResponse(NewsResponse map) {
    return News(
      totalResults: map.totalResults,
      articles: map.articles.map((x) => Article.fromResponse(x)).toList(),
    );
  }

  @override
  bool operator ==(covariant News other) {
    if (identical(this, other)) return true;

    return other.totalResults == totalResults &&
        listEquals(other.articles, articles);
  }

  @override
  int get hashCode => totalResults.hashCode ^ articles.hashCode;

  @override
  String toString() =>
      'TopHeadlines(totalResults: $totalResults, articles: $articles)';

  News copyWith({
    int? totalResults,
    List<Article>? articles,
  }) {
    return News(
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }
}
