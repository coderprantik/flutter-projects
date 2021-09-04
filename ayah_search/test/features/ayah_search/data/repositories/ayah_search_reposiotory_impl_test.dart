import 'package:ayah_search/core/error/exceptions.dart';
import 'package:ayah_search/core/error/failures.dart';
import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:ayah_search/features/ayah_search/data/repositories/ayah_search_repository_impl.dart';
import 'package:ayah_search/main.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'ayah_search_reposiotory_impl.mocks.dart';

// @GenerateMocks([
//   AyahSearchRemoteDataSource,
//   AyahSearchLocalDataSource,
//   NetworkInfo,
// ])
void main() {
  late MockAyahSearchRemoteDataSource mockRemoteDataSource;
  late MockAyahSearchLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late AyahSearchRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockAyahSearchRemoteDataSource();
    mockLocalDataSource = MockAyahSearchLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AyahSearchRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tQuery = "1:2";
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

  void runTestsNoCached(Function body) {
    group('No cached data is present for the query', () {
      setUp(() {
        when(mockLocalDataSource.hasAyah(any)).thenAnswer((_) async => false);
      });

      body();
    });
  }

  void runTestsOnline(Function body) {
    setUp(() {
      when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
    });

    body();
  }

  group('getArabicAyah', () {
    test(
      'should check first if any cached data is present for the query',
      () async {
        // arrange
        when(mockLocalDataSource.hasAyah(any)).thenAnswer((_) async => true);
        when(mockLocalDataSource.getArabicAyah(any)) // else MissingStubError
            .thenAnswer((_) async => tAyahModel);
        // act
        await repository.getArabicAyah(tQuery);
        // assert
        verify(mockLocalDataSource.hasAyah(tQuery));
      },
    );

    test(
      'should return the cached Ayah when the data is present in cache',
      () async {
        // arrange
        when(mockLocalDataSource.hasAyah(any)).thenAnswer((_) async => true);
        when(mockLocalDataSource.getArabicAyah(any))
            .thenAnswer((_) async => tAyahModel);
        // act
        final result = await repository.getArabicAyah(tQuery);
        // assert
        expect(result, equals(Right(tAyah)));
        verify(mockLocalDataSource.getArabicAyah(tQuery));
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return CacheFailure when the call local data source is unsuccessful',
      () async {
        // arrange
        when(mockLocalDataSource.hasAyah(any)).thenAnswer((_) async => true);
        when(mockLocalDataSource.getArabicAyah(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.getArabicAyah(tQuery);
        // assert
        expect(result, equals(Left(CacheFailure())));
      },
    );

    runTestsNoCached(() {
      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
          when(mockRemoteDataSource.getArabicAyah(any)) // else MissingStubError
              .thenAnswer((_) async => tAyahModel);
          // act
          await repository.getArabicAyah(tQuery);
          // assert
          verify(mockNetworkInfo.hasConnection);
        },
      );

      test(
        'should return CacheFailure when the device is offline',
        () async {
          // arrange
          when(mockNetworkInfo.hasConnection).thenAnswer((_) async => false);
          // act
          final result = await repository.getArabicAyah(tQuery);
          // assert
          expect(result, Left(CacheFailure()));
        },
      );

      runTestsOnline(() {
        test(
          'should return remote data when the call reomote data sourse is successful',
          () async {
            // arrange
            when(mockRemoteDataSource.getArabicAyah(any))
                .thenAnswer((_) async => tAyahModel);
            // act
            final result = await repository.getArabicAyah(tQuery);
            // assert
            expect(result, equals(Right(tAyah)));
            verify(mockRemoteDataSource.getArabicAyah(tQuery));
          },
        );

        test(
          'should cache the data locally when the call remote data is successful',
          () async {
            // arrange
            when(mockRemoteDataSource.getArabicAyah(any))
                .thenAnswer((_) async => tAyahModel);
            // act
            await repository.getArabicAyah(tQuery);
            // assert
            verify(mockLocalDataSource.cacheAyah(tAyahModel));
          },
        );
        test(
          'should return server failure when the call remote data source is unsuccessful',
          () async {
            // arrange
            when(mockRemoteDataSource.getArabicAyah(any))
                .thenThrow(ServerException());
            // act
            final result = await repository.getArabicAyah(tQuery);
            // assert
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
    });
  });

  group('getTranslationAyah', () {
    void setGetTranslationAyahSuccessful() {
      when(mockLocalDataSource.getTranslationAyah(
        query: anyNamed('query'),
        identifier: anyNamed('identifier'),
      )).thenAnswer((_) async => tAyahModel);
    }

    test(
      'should check first if any cached data is present for the query',
      () async {
        // arrange
        when(mockLocalDataSource.hasAyah(any)).thenAnswer((_) async => true);
        setGetTranslationAyahSuccessful();
        // act
        await repository.getTranslationAyah(
          query: tQuery,
          identifier: currentIdentifier,
        );
        // assert
        verify(mockLocalDataSource.hasAyah(tQuery));
      },
    );

    test(
      'should return the cached Ayah when data is present in cache',
      () async {
        // arrange
        when(mockLocalDataSource.hasAyah(any)).thenAnswer((_) async => true);
        setGetTranslationAyahSuccessful();
        // act
        final result = await repository.getTranslationAyah(
          query: tQuery,
          identifier: currentIdentifier,
        );
        // assert
        expect(result, equals(Right(tAyah)));
        verify(mockLocalDataSource.getTranslationAyah(
            query: tQuery, identifier: currentIdentifier));
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return CacheFailure when the call local data source is unsuccessful',
      () async {
        // arrange
        when(mockLocalDataSource.hasAyah(any)).thenAnswer((_) async => true);
        when(
          mockLocalDataSource.getTranslationAyah(
            query: anyNamed('query'),
            identifier: anyNamed('identifier'),
          ),
        ).thenThrow(CacheException());
        // act
        final result = await repository.getArabicAyah(tQuery);
        // assert
        expect(result, equals(Left(CacheFailure())));
      },
    );

    runTestsNoCached(() {
      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
          when(mockRemoteDataSource.getArabicAyah(any)) // else MissingStubError
              .thenAnswer((_) async => tAyahModel);
          // act
          await repository.getArabicAyah(tQuery);
          // assert
          verify(mockNetworkInfo.hasConnection);
        },
      );

      test(
        'should return CacheFailure when the device is offline',
        () async {
          // arrange
          when(mockNetworkInfo.hasConnection).thenAnswer((_) async => false);
          // act
          final result = await repository.getArabicAyah(tQuery);
          // assert
          expect(result, Left(CacheFailure()));
        },
      );

      runTestsOnline(() {
        test(
          'should return remote data when the call reomote data sourse is successful',
          () async {
            // arrange
            when(mockRemoteDataSource.getArabicAyah(any))
                .thenAnswer((_) async => tAyahModel);
            // act
            final result = await repository.getArabicAyah(tQuery);
            // assert
            expect(result, equals(Right(tAyah)));
            verify(mockRemoteDataSource.getArabicAyah(tQuery));
          },
        );

        test(
          'should cache the data locally when the call remote data is successful',
          () async {
            // arrange
            when(mockRemoteDataSource.getArabicAyah(any))
                .thenAnswer((_) async => tAyahModel);
            // act
            await repository.getArabicAyah(tQuery);
            // assert
            verify(mockLocalDataSource.cacheAyah(tAyahModel));
          },
        );
        test(
          'should return server failure when the call remote data source is unsuccessful',
          () async {
            // arrange
            when(mockRemoteDataSource.getArabicAyah(any))
                .thenThrow(ServerException());
            // act
            final result = await repository.getArabicAyah(tQuery);
            // assert
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
    });
  });
}
