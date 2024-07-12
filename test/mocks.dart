import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';

class MockDatabase extends Mock implements Database {}

class MockStoreRef extends Mock implements StoreRef {}

class MockDio extends Mock implements Dio {}

class MockInterceptors extends Mock implements Interceptors {}

class MockResponse extends Mock implements Response {}

class MockDotEnv extends Mock implements DotEnv {}
