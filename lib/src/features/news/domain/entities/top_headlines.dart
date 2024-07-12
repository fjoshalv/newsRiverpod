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
}
