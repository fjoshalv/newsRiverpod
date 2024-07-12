import 'package:flutter_turnkey_test/src/features/news/data/models/article_response.dart';
import 'package:flutter_turnkey_test/src/shared/data/models/response_json_factory.dart';

class TopHeadlinesResponse {
  const TopHeadlinesResponse({
    required this.totalResults,
    required this.articles,
  });

  final int totalResults;
  final List<ArticleResponse> articles;

  factory TopHeadlinesResponse.fromMap(Map<String, dynamic> map) {
    return TopHeadlinesResponse(
      totalResults: map['totalResults'] as int,
      articles: (map['articles'] as List<int>)
          .map<ArticleResponse>(
            (x) => ArticleResponse.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class TopHeadlinesDeserializer
    implements ResponseJsonFactory<TopHeadlinesResponse> {
  const TopHeadlinesDeserializer();

  @override
  TopHeadlinesResponse fromMap(dynamic json) {
    return TopHeadlinesResponse.fromMap(json);
  }
}
