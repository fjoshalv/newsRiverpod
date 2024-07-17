import 'package:flutter_test/flutter_test.dart';
import 'package:news_riverpod/src/features/news/data/models/article_response.dart';
import 'package:news_riverpod/src/features/news/data/models/news_response.dart';
import 'package:news_riverpod/src/features/news/data/news_remote_repository.dart';
import 'package:news_riverpod/src/features/news/domain/entities/article.dart';
import 'package:news_riverpod/src/features/news/domain/entities/news.dart';
import 'package:news_riverpod/src/shared/domain/entities/app_request.dart';
import 'package:news_riverpod/src/shared/domain/params/network_params.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  const paginationParams = NetworkParams(page: 1);

  const deserializer = NewsDeserializer();

  late MockNetworkManager networkManager;

  setUp(() {
    networkManager = MockNetworkManager();
  });

  group(
    'getTopHeadlines -',
    () {
      test(
        'should call sendRequest with the correct parameters',
        () async {
          // Arrange

          when(
            () => networkManager.sendRequest(
              request: AppRequest.topHeadlines,
              deserializer: deserializer,
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer(
            (_) async => NewsResponse(
              totalResults: 1,
              articles: [ArticleResponse.example],
            ),
          );

          // Act
          final repository = NewsRemoteRepository(networkManager);
          await repository.getTopHeadlines(paginationParams);

          // Assert
          verify(
            () => networkManager.sendRequest(
              request: AppRequest.topHeadlines,
              deserializer: deserializer,
              parameters: paginationParams.toMap()..addAll({'country': 'us'}),
            ),
          ).called(1);
        },
      );

      test(
        'should return TopHeadlines when the request is successful',
        () async {
          // Arrange
          when(
            () => networkManager.sendRequest(
              request: AppRequest.topHeadlines,
              deserializer: deserializer,
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer(
            (_) async => NewsResponse(
              totalResults: 1,
              articles: [ArticleResponse.example],
            ),
          );

          // Act
          final repository = NewsRemoteRepository(networkManager);
          final result = await repository.getTopHeadlines(paginationParams);

          // Assert
          expect(
            result,
            News(
              totalResults: 1,
              articles: [Article.example],
            ),
          );
        },
      );
    },
  );
}
