// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:news_riverpod/src/features/news/data/models/article_response.dart';
import 'package:news_riverpod/src/shared/data/models/response_json_factory.dart';

class NewsResponse {
  const NewsResponse({
    required this.totalResults,
    required this.articles,
  });

  final int totalResults;
  final List<ArticleResponse> articles;

  factory NewsResponse.fromMap(Map<String, dynamic> map) {
    return NewsResponse(
      totalResults: map['totalResults'] as int,
      articles: (map['articles'] as List)
          .map<ArticleResponse>(
            (x) => ArticleResponse.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  bool operator ==(covariant NewsResponse other) {
    if (identical(this, other)) return true;

    return other.totalResults == totalResults &&
        listEquals(other.articles, articles);
  }

  @override
  int get hashCode => totalResults.hashCode ^ articles.hashCode;
}

class NewsDeserializer implements ResponseJsonFactory<NewsResponse> {
  const NewsDeserializer();

  @override
  NewsResponse fromMap(dynamic json) {
    return NewsResponse.fromMap(json);
  }
}
