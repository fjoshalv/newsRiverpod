enum EnvKeys {
  newsApiUrl,
  newsApiKey;

  String get value {
    switch (this) {
      case EnvKeys.newsApiUrl:
        return 'NEWS_API_URL';
      case EnvKeys.newsApiKey:
        return 'NEWS_API_KEY';
    }
  }
}
