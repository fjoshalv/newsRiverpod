import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_riverpod/src/features/news/data/news_remote_repository.dart';
import 'package:news_riverpod/src/shared/data/data_sources/network_manager.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';

class MockDatabase extends Mock implements Database {}

class MockStoreRef extends Mock implements StoreRef {}

class MockDio extends Mock implements Dio {}

class MockInterceptors extends Mock implements Interceptors {}

class MockResponse extends Mock implements Response {}

class MockDotEnv extends Mock implements DotEnv {}

class MockNetworkManager extends Mock implements NetworkManager {}

class MockNewsRemoteRepository extends Mock implements NewsRemoteRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
