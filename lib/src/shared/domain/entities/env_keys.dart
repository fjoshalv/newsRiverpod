enum EnkKeys {
  newsApiUrl,
  newsApiKey;

  String get value {
    switch (this) {
      case EnkKeys.newsApiUrl:
        return 'NEWS_API_URL';
      case EnkKeys.newsApiKey:
        return 'NEWS_API_KEY';
    }
  }
}
