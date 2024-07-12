import 'package:flutter_turnkey_test/src/features/news/data/models/source_response.dart';

class ArticleResponse {
  const ArticleResponse({
    required this.title,
    required this.url,
    required this.publishedAt,
    required this.sourceResponse,
    this.author,
    this.description,
    this.urlToImage,
    this.content,
  });
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;
  final SourceResponse sourceResponse;
}
