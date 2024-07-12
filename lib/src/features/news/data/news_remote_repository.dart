// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_turnkey_test/src/features/news/data/models/top_headlines_response.dart';
import 'package:flutter_turnkey_test/src/shared/data/data_sources/network_manager.dart';
import 'package:flutter_turnkey_test/src/shared/domain/entities/app_request.dart';
import 'package:flutter_turnkey_test/src/shared/domain/params/pagination_params.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_remote_repository.g.dart';

class NewsRemoteRepository {
  final NetworkManager networkManager;

  const NewsRemoteRepository(
    this.networkManager,
  );

  Future<TopHeadlinesResponse> getTopHeadlines(PaginationParams params) {
    return networkManager.sendRequest(
      request: AppRequest.topHeadlines,
      deserializer: const TopHeadlinesDeserializer(),
      pathParameters: params.toMap(),
    );
  }
}

@riverpod
NewsRemoteRepository newsRemoteRepository(NewsRemoteRepositoryRef ref) {
  return NewsRemoteRepository(
    ref.watch(networkManagerProvider),
  );
}
