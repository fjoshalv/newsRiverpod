import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_turnkey_test/src/features/news/data/news_remote_repository.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/article.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/news.dart';
import 'package:flutter_turnkey_test/src/features/news/presentation/trends/trends_controller.dart';
import 'package:flutter_turnkey_test/src/features/news/presentation/trends/trends_state.dart';
import 'package:flutter_turnkey_test/src/shared/data/models/app_exception.dart';
import 'package:flutter_turnkey_test/src/shared/domain/params/pagination_params.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  ProviderContainer makeProviderContainer(
      MockNewsRemoteRepository newsRemoteRepository) {
    return ProviderContainer(
      overrides: [
        newsRemoteRepositoryProvider.overrideWithValue(newsRemoteRepository),
      ],
    );
  }

  setUpAll(() {
    registerFallbackValue(News(
      totalResults: 1,
      articles: [Article.example],
    ));

    registerFallbackValue(const PaginationParams(page: 1));

    registerFallbackValue(
      AsyncData(
        TrendsState(page: 1, hasReachedMax: false, articles: [Article.example]),
      ),
    );
  });

  test('initial state is AsyncLoading', () {
    // setup
    final newsRemoteRepository = MockNewsRemoteRepository();

    final container = makeProviderContainer(newsRemoteRepository);

    final listener = Listener<AsyncValue<TrendsState>>();

    // act

    container.listen(
      trendsControllerProvider,
      listener.call,
      fireImmediately: true,
    );

    // assert

    verify(() => listener(null, const AsyncLoading<TrendsState>()));
  });

  test('state is AsyncLoading and AsyncData after build', () async {
    final newsRemoteRepository = MockNewsRemoteRepository();

    when(() => newsRemoteRepository.getTopHeadlines(any())).thenAnswer(
      (_) async => News(
        totalResults: 1,
        articles: [Article.example],
      ),
    );

    final container = makeProviderContainer(newsRemoteRepository);

    final listener = Listener<AsyncValue<TrendsState>>();

    container.listen(
      trendsControllerProvider,
      listener.call,
      fireImmediately: true,
    );

    await container.read(trendsControllerProvider.notifier).build();

    verifyInOrder([
      () => listener(
            null,
            const AsyncLoading<TrendsState>(),
          ),
      () => listener(
            const AsyncLoading<TrendsState>(),
            any(
              that: isA<AsyncData<TrendsState>>(),
            ),
          ),
    ]);
  });

  test(
    'state is AsyncLoading and AsyncError after network call fails',
    () async {
      final newsRemoteRepository = MockNewsRemoteRepository();
      const exception = AppException(message: 'error');

      when(() => newsRemoteRepository.getTopHeadlines(any())).thenThrow(
        exception,
      );

      final container = makeProviderContainer(newsRemoteRepository);

      final listener = Listener<AsyncValue<TrendsState>>();

      container.listen(
        trendsControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      final buildFunction =
          container.read(trendsControllerProvider.notifier).build;

      expect(
        buildFunction,
        throwsA(
          isA<AppException>(),
        ),
      );

      // Tweak to avoid unhandled exception within the test but to force the
      // listener to be called with the error state
      try {
        await buildFunction();
      } catch (e) {
        // do nothing
      }

      verifyInOrder(
        [
          () => listener(
                null,
                const AsyncLoading<TrendsState>(),
              ),
          () => listener(
                const AsyncLoading<TrendsState>(),
                any(
                  that: isA<AsyncError<TrendsState>>(),
                ),
              ),
        ],
      );
    },
  );

  group(
    'loadMoreHeadlines -',
    () {
      test('state is AsyncData after successful network call', () async {
        final newsRemoteRepository = MockNewsRemoteRepository();

        when(() => newsRemoteRepository.getTopHeadlines(any())).thenAnswer(
          (_) async => News(
            totalResults: 1,
            articles: [Article.example],
          ),
        );

        final container = makeProviderContainer(newsRemoteRepository);

        final listener = Listener<AsyncValue<TrendsState>>();

        container.listen(
          trendsControllerProvider,
          listener.call,
          fireImmediately: true,
        );

        await container
            .read(trendsControllerProvider.notifier)
            .loadMoreHeadlines();

        verifyInOrder(
          [
            () => listener(
                  null,
                  const AsyncLoading<TrendsState>(),
                ),
            () => listener(
                  const AsyncLoading<TrendsState>(),
                  any(
                    that: isA<AsyncData<TrendsState>>(),
                  ),
                ),
            () => listener(
                  any(
                    that: isA<AsyncData<TrendsState>>(),
                  ),
                  any(
                    that: isA<AsyncData<TrendsState>>(),
                  ),
                ),
          ],
        );
      });

      test('state is AsyncError after unsuccessful network call', () async {
        final newsRemoteRepository = MockNewsRemoteRepository();

        when(() => newsRemoteRepository.getTopHeadlines(any())).thenAnswer(
          (_) async => News(
            totalResults: 1,
            articles: [Article.example],
          ),
        );

        final container = makeProviderContainer(newsRemoteRepository);

        final listener = Listener<AsyncValue<TrendsState>>();

        container.listen(
          trendsControllerProvider,
          listener.call,
          fireImmediately: true,
        );

        await container.read(trendsControllerProvider.notifier).build();

        when(() => newsRemoteRepository.getTopHeadlines(any())).thenThrow(
          const AppException(message: 'error'),
        );

        await container
            .read(trendsControllerProvider.notifier)
            .loadMoreHeadlines();

        verifyInOrder(
          [
            () => listener(
                  null,
                  const AsyncLoading<TrendsState>(),
                ),
            () => listener(
                  const AsyncLoading<TrendsState>(),
                  any(
                    that: isA<AsyncData<TrendsState>>(),
                  ),
                ),
            () => listener(
                  any(
                    that: isA<AsyncData<TrendsState>>(),
                  ),
                  any(
                    that: isA<AsyncError<TrendsState>>(),
                  ),
                ),
          ],
        );
      });

      test('page is incremented after call', () async {
        final newsRemoteRepository = MockNewsRemoteRepository();

        when(() => newsRemoteRepository.getTopHeadlines(any())).thenAnswer(
          (_) async => News(
            totalResults: 1,
            articles: [Article.example],
          ),
        );

        final container = makeProviderContainer(newsRemoteRepository);

        final listener = Listener<AsyncValue<TrendsState>>();

        container.listen(
          trendsControllerProvider,
          listener.call,
          fireImmediately: true,
        );

        await container.read(trendsControllerProvider.notifier).build();

        await container
            .read(trendsControllerProvider.notifier)
            .loadMoreHeadlines();

        final state = container.read(trendsControllerProvider);

        expect(state.value?.page, equals(2));
      });
    },
  );
}
