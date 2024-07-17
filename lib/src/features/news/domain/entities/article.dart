// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  bool operator ==(covariant Article other) {
    if (identical(this, other)) return true;

    return other.author == author &&
        other.title == title &&
        other.description == description &&
        other.url == url &&
        other.urlToImage == urlToImage &&
        other.publishedAt == publishedAt &&
        other.sourceName == sourceName;
  }

  @override
  int get hashCode {
    return author.hashCode ^
        title.hashCode ^
        description.hashCode ^
        url.hashCode ^
        urlToImage.hashCode ^
        publishedAt.hashCode ^
        sourceName.hashCode;
  }

  @override
  String toString() {
    return 'Article(author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, sourceName: $sourceName)';
  }
}
