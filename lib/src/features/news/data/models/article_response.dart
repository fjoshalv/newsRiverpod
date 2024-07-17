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
  });
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;

  final SourceResponse sourceResponse;

  factory ArticleResponse.fromMap(Map<String, dynamic> map) => ArticleResponse(
        author: map['author'],
        title: map['title'],
        description: map['description'],
        url: map['url'],
        urlToImage: map['urlToImage'],
        publishedAt: DateTime.parse(map['publishedAt']),
        sourceResponse: SourceResponse.fromMap(map['source']),
      );

  static final example = ArticleResponse(
    author: 'John Doe',
    title: 'Example Article',
    description: 'This is an example article',
    url: 'https://example.com',
    urlToImage: 'https://example.com/image.jpg',
    publishedAt: DateTime(2022, 1, 1),
    sourceResponse: SourceResponse.example,
  );
}
