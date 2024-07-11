import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_turnkey_test/src/shared/domain/entities/app_request.dart';
import 'package:flutter_turnkey_test/src/shared/domain/entities/rest_method.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_manager.g.dart';

class NetworkManager {
  NetworkManager({
    required this.networkManager,
    required this.baseUrl,
  }) {
    _initializeInterceptors();
  }

  final Dio networkManager;
  final String baseUrl;

  Future<void> _initializeInterceptors() async {
    networkManager.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // TODO: Implement token addition to headers
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
    required T Function(dynamic json) deserializer,
    Map<String, dynamic>? parameters,
    Map<String, String>? pathParameters,
  }) async {
    Response response;
    try {
      final url = baseUrl + request.path(pathParameters);
      switch (request.restMethod) {
        case RestMethod.get:
          response = await networkManager.get(url, queryParameters: parameters);
          break;
      }
      return deserializer(response.data);
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
    baseUrl: '',
  );
}
