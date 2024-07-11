// TODO: Remove enum "request" when having at least one real request
import 'package:flutter_turnkey_test/src/shared/domain/entities/rest_method.dart';

enum AppRequest {
  request;

  String path(Map<String, String>? pathParameters) {
    late String path;

    switch (this) {
      case AppRequest.request:
        path = '/request';
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
    };
  }
}
