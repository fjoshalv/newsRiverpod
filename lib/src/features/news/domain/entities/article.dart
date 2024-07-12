import 'package:flutter_turnkey_test/src/features/news/data/models/article_response.dart';

class Article {
  const Article({
    required this.title,
    required this.url,
    required this.publishedAt,
    required this.sourceName,
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
  final String sourceName;

  factory Article.fromResponse(ArticleResponse response) => Article(
        author: response.author,
        title: response.title,
        description: response.description,
        url: response.url,
        urlToImage: response.urlToImage,
        publishedAt: response.publishedAt.toLocal(),
        sourceName: response.sourceResponse.name,
      );

  static final example = Article(
    author: 'John Doe',
    title: 'Example Article',
    description: 'This is an example article',
    url: 'https://example.com',
    urlToImage: 'https://example.com/image.jpg',
    publishedAt: DateTime(2022, 1, 1),
    sourceName: 'Example News',
  );
}
