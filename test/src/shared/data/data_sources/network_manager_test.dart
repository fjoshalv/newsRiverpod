import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_riverpod/src/shared/data/data_sources/network_manager.dart';
import 'package:news_riverpod/src/shared/data/models/response_json_factory.dart';
import 'package:news_riverpod/src/shared/domain/entities/app_request.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late MockDio dio;
  late MockDotEnv dotEnv;
  late MockInterceptors interceptors;

  setUp(() {
    dio = MockDio();
    dotEnv = MockDotEnv();
    interceptors = MockInterceptors();
  });

  test('NetworkManager should initialize interceptors', () {
    // Setup

    when(() => dio.interceptors.add(any())).thenReturn(null);
    when(() => dio.interceptors).thenReturn(interceptors);

    // Run
    NetworkManager(networkManager: dio, env: dotEnv);

    // Verify
    // * Two interceptor are added

    verify(() => dio.interceptors.add(any())).called(2);
  });

  test('Should close client when dispose is called', () {
    // Setup

    when(() => dio.interceptors).thenReturn(interceptors);
    when(() => dio.close()).thenReturn(null);

    // Run
    final networkManager = NetworkManager(networkManager: dio, env: dotEnv);
    networkManager.dispose();

    // Verify
    verify(() => dio.close()).called(1);
  });

  group(
    'sendRequest -',
    () {
      const baseUrl = 'url';
      const request = AppRequest.request;
      final url = '$baseUrl${request.path(null)}';

      setUp(() {
        when(() => dio.interceptors).thenReturn(interceptors);
        when(() => dotEnv.get(any())).thenReturn(baseUrl);
      });
      test('Should return response when request is successful', () async {
        // Setup

        when(() => dio.get(any())).thenAnswer((_) async => MockResponse());

        // Run

        final networkManager = NetworkManager(networkManager: dio, env: dotEnv);
        final result = await networkManager.sendRequest<void>(
          request: AppRequest.request,
          deserializer: const EmptyResponseJsonFactory(),
        );

        // Verify
        expect(() => result, isA<void>());
      });

      test(
        'Given that request type is GET, '
        'When sendRequest is called, '
        'Then the client get method is called',
        () async {
          // Setup
          when(() => dio.get(any())).thenAnswer((_) async => MockResponse());
          // Run
          final networkManager =
              NetworkManager(networkManager: dio, env: dotEnv);
          await networkManager.sendRequest<void>(
            request: AppRequest.request,
            deserializer: const EmptyResponseJsonFactory(),
          );

          // Verify
          verify(() => dio.get(url, queryParameters: null)).called(1);
        },
      );
    },
  );
}
