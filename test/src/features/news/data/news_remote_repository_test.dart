import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_turnkey_test/src/features/news/data/models/article_response.dart';
import 'package:flutter_turnkey_test/src/features/news/data/models/top_headlines_response.dart';
import 'package:flutter_turnkey_test/src/features/news/data/news_remote_repository.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/article.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/top_headlines.dart';
import 'package:flutter_turnkey_test/src/shared/domain/entities/app_request.dart';
import 'package:flutter_turnkey_test/src/shared/domain/params/pagination_params.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  const paginationParams = PaginationParams(page: 1);

  const deserializer = TopHeadlinesDeserializer();

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
            (_) async => TopHeadlinesResponse(
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
            (_) async => TopHeadlinesResponse(
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
            TopHeadlines(
              totalResults: 1,
              articles: [Article.example],
            ),
          );
        },
      );
    },
  );
}
