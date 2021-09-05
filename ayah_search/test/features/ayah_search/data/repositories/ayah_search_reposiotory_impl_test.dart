import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:ayah_search/features/ayah_search/data/repositories/ayah_search_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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
  final tQuery = '1:2';
  final tAyahModel = AyahModel(
    surahNumber: 1,
    ayahNumber: 2,
    surahName: "surahName",
    surahNameTranslation: "surahNameTranslation",
    revelationType: "revelationType",
    sajda: false,
    identifier: 'identifier',
    type: "type",
    editionName: "editionName",
    direction: "direction",
    text: "text",
  );
  final tAyah = tAyahModel;

  group('getArabicAyah', () {
    test(
      'should check local cache first',
      () async {
        // arrange
        when(mocklocalDataSource.getArabicAyah())
            .thenAnswer((_) async => tAyahModel);
        // act
        await repository.getArabicAyah(query: tQuery);
        // assert
      },
    );
  });
}
