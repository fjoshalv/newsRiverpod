import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_turnkey_test/src/shared/data/models/response_json_factory.dart';
import 'package:flutter_turnkey_test/src/shared/domain/entities/app_request.dart';
import 'package:flutter_turnkey_test/src/shared/domain/entities/env_keys.dart';
import 'package:flutter_turnkey_test/src/shared/domain/entities/rest_method.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_manager.g.dart';

class NetworkManager {
  NetworkManager({
    required this.networkManager,
    required this.env,
  }) {
    _initializeInterceptors();
  }

  final Dio networkManager;

  final DotEnv env;

  Future<void> _initializeInterceptors() async {
    networkManager.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = env.get(EnvKeys.newsApiKey.value);

          options.headers['Authorization'] = 'bearer $token';

          return handler.next(options);
        },
      ),
    );

    networkManager.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (value) {
          if (kDebugMode) {
            log(value.toString());
          }
        },
      ),
    );
  }

  Future<T> sendRequest<T>({
    required AppRequest request,
    required ResponseJsonFactory<T> deserializer,
    Map<String, dynamic>? parameters,
    Map<String, String>? pathParameters,
  }) async {
    Response response;
    try {
      final baseUrl = env.get(EnvKeys.newsApiUrl.value);
      final url = baseUrl + request.path(pathParameters);
      switch (request.restMethod) {
        case RestMethod.get:
          response = await networkManager.get(url, queryParameters: parameters);
          break;
      }
      return deserializer.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  void dispose() => networkManager.close();
}

@riverpod
NetworkManager networkManager(NetworkManagerRef ref) {
  return NetworkManager(
    networkManager: Dio(),
    env: dotenv,
  );
}
