import 'package:flutter_turnkey_test/src/features/news/data/models/article_response.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class TopHeadlinesResponse {
  const TopHeadlinesResponse({
    required this.totalResults,
    required this.articles,
  });

  final int totalResults;
  final List<ArticleResponse> articles;
}
