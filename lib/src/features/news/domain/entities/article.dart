// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_riverpod/src/features/news/data/models/article_response.dart';

class Article {
  const Article({
    required this.id,
    required this.title,
    required this.url,
    required this.publishedAt,
    required this.sourceName,
    this.author,
    this.description,
    this.urlToImage,
  });

  final String id;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String sourceName;

  factory Article.fromResponse(ArticleResponse response) {
    final localPublishedAt = response.publishedAt.toLocal();
    final id = '${localPublishedAt.millisecondsSinceEpoch}'
        '${response.sourceResponse.name}${response.title}';
    return Article(
      id: id,
      author: response.author,
      title: response.title,
      description: response.description,
      url: response.url,
      urlToImage: response.urlToImage,
      publishedAt: localPublishedAt,
      sourceName: response.sourceResponse.name,
    );
  }

  static final example = Article(
    id: 'example',
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

    return other.id == id &&
        other.author == author &&
        other.title == title &&
        other.description == description &&
        other.url == url &&
        other.urlToImage == urlToImage &&
        other.publishedAt == publishedAt &&
        other.sourceName == sourceName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        title.hashCode ^
        description.hashCode ^
        url.hashCode ^
        urlToImage.hashCode ^
        publishedAt.hashCode ^
        sourceName.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
      'sourceName': sourceName,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as String,
      author: map['author'] != null ? map['author'] as String : null,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      url: map['url'] as String,
      urlToImage:
          map['urlToImage'] != null ? map['urlToImage'] as String : null,
      publishedAt:
          DateTime.fromMillisecondsSinceEpoch(map['publishedAt'] as int),
      sourceName: map['sourceName'] as String,
    );
  }

  @override
  String toString() {
    return 'Article(id: $id, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, sourceName: $sourceName)';
  }
}
