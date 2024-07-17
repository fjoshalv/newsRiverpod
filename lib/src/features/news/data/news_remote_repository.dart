// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_turnkey_test/src/features/news/data/models/news_response.dart';
import 'package:flutter_turnkey_test/src/features/news/domain/entities/news.dart';
import 'package:flutter_turnkey_test/src/shared/data/data_sources/network_manager.dart';
import 'package:flutter_turnkey_test/src/shared/domain/entities/app_request.dart';
import 'package:flutter_turnkey_test/src/shared/domain/params/network_params.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_remote_repository.g.dart';

class NewsRemoteRepository {
  final NetworkManager networkManager;

  const NewsRemoteRepository(
    this.networkManager,
  );

  Future<News> getTopHeadlines(NetworkParams params) async {
    final response = await networkManager.sendRequest(
      request: AppRequest.topHeadlines,
      deserializer: const NewsDeserializer(),
      parameters: params.toMap()
        ..addAll({
          'country': 'us',
        }),
    );

    return News.fromResponse(response);
  }

  Future<News> getEverything(NetworkParams params) async {
    final response = await networkManager.sendRequest(
      request: AppRequest.topHeadlines,
      deserializer: const NewsDeserializer(),
      parameters: params.toMap(),
    );

    return News.fromResponse(response);
  }
}

@riverpod
NewsRemoteRepository newsRemoteRepository(NewsRemoteRepositoryRef ref) {
  return NewsRemoteRepository(
    ref.watch(networkManagerProvider),
  );
}
