import 'package:news_riverpod/src/shared/domain/entities/rest_method.dart';

enum AppRequest {
  request,
  topHeadlines,
  everything,
  ;

  String path(Map<String, String>? pathParameters) {
    late String path;

    switch (this) {
      case AppRequest.request:
        path = '/request';
        break;
      case AppRequest.topHeadlines:
        path = '/top-headlines';
        break;
      case AppRequest.everything:
        path = '/everything';
        break;
    }

    if (pathParameters != null) {
      for (final pathParameter in pathParameters.entries) {
        path = path.replaceAll(
          '{${pathParameter.key}}',
          pathParameter.value,
        );
      }
    }
    return path;
  }

  RestMethod get restMethod {
    return switch (this) {
      AppRequest.request => RestMethod.get,
      AppRequest.topHeadlines => RestMethod.get,
      AppRequest.everything => RestMethod.get,
    };
  }
}
