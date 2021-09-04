import 'package:ayah_search/features/ayah_search/data/repositories/ayah_search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'ayah_search_reposiotory_impl.mocks.dart';

/* @GenerateMocks([
  AyahSearchRemoteDataSource,
  AyahSearchLocalDataSource,
  NetworkInfo,
]) */
void main() {
  late MockAyahSearchRemoteDataSource mockRemoteDataSource;
  late MockAyahSearchLocalDataSource mocklocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late AyahSearchRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockAyahSearchRemoteDataSource();
    mocklocalDataSource = MockAyahSearchLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AyahSearchRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mocklocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
