import 'dart:io';

import 'package:ayah_search/core/error/exceptions.dart';
import 'package:ayah_search/core/error/failures.dart';
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
  late MockAyahSearchLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late AyahSearchRepositoryImpl repository;
  late String tIdentifier;

  setUp(() {
    mockRemoteDataSource = MockAyahSearchRemoteDataSource();
    mockLocalDataSource = MockAyahSearchLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AyahSearchRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
    tIdentifier = 'bn.bengali';
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
        when(mockLocalDataSource.getArabicAyah(query: anyNamed('query')))
            .thenAnswer((_) async => tAyahModel);
        // act
        await repository.getArabicAyah(query: tQuery);
        // assert
        verify(mockLocalDataSource.getArabicAyah(query: tQuery));
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return cache data when the call local data source successful',
      () async {
        // arrange
        when(mockLocalDataSource.getArabicAyah(query: anyNamed('query')))
            .thenAnswer((_) async => tAyahModel);
        // act
        final result = await repository.getArabicAyah(query: tQuery);
        // assert
        expect(result, equals(Right(tAyah)));
      },
    );

    group('No Cache (CacheException)', () {
      setUp(() {
        when(
          mockLocalDataSource.getArabicAyah(query: anyNamed('query')),
        ).thenThrow(CacheException());
      });
      test(
        'should return remote data when the call remote data is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getArabicAyah(query: anyNamed('query')))
              .thenAnswer((_) async => tAyahModel);
          when(mockLocalDataSource.cacheAyah(any))
              .thenAnswer((_) async => true);
          // act
          final result = await repository.getArabicAyah(query: tQuery);
          // assert
          verify(mockRemoteDataSource.getArabicAyah(query: tQuery));
          expect(result, equals(Right(tAyah)));
        },
      );

      test(
        'should cache remote data when the call remote data is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getArabicAyah(query: anyNamed('query')))
              .thenAnswer((_) async => tAyahModel);
          when(mockLocalDataSource.cacheAyah(any))
              .thenAnswer((_) async => true);
          // act
          await repository.getArabicAyah(query: tQuery);
          // assert
          verify(mockLocalDataSource.cacheAyah(tAyahModel));
        },
      );

      test(
        'should return NoInterFailure when the call remote data source throw SocketException',
        () async {
          // arrange
          when(mockRemoteDataSource.getArabicAyah(query: anyNamed('query')))
              .thenThrow(SocketException('No Internet'));
          // act
          final result = await repository.getArabicAyah(query: tQuery);
          // assert
          expect(result, equals(Left(NoInternetFailure())));
        },
      );

      test(
        'should return ServerException with proper message when the call remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getArabicAyah(query: anyNamed('query')))
              .thenThrow(ServerException('Server Failure'));
          // act
          final result = await repository.getArabicAyah(query: tQuery);
          // assert
          expect(result, equals(Left(ServerFailure('Server Failure'))));
        },
      );
    });
  });

  group('getTranslationAyah', () {
    test(
      'should check local cache first',
      () async {
        // arrange
        when(mockLocalDataSource.getTranslationAyah(
                query: anyNamed('query'), identifier: anyNamed('identifier')))
            .thenAnswer((_) async => tAyahModel);
        // act
        await repository.getTranslationAyah(
          query: tQuery,
          identifier: tIdentifier,
        );
        // assert
        verify(mockLocalDataSource.getTranslationAyah(
          query: tQuery,
          identifier: tIdentifier,
        ));
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return cache data when the call local data source successful',
      () async {
        // arrange
        when(mockLocalDataSource.getTranslationAyah(
          query: anyNamed('query'),
          identifier: anyNamed('identifier'),
        )).thenAnswer((_) async => tAyahModel);
        // act
        final result = await repository.getTranslationAyah(
          query: tQuery,
          identifier: tIdentifier,
        );
        // assert
        expect(result, equals(Right(tAyah)));
      },
    );

    group('No Cache (CahceException)', () {
      setUp(() {
        when(mockLocalDataSource.getTranslationAyah(
          query: anyNamed('query'),
          identifier: anyNamed('identifier'),
        )).thenThrow(CacheException());
      });

      test(
        'should return remote data when the call remote data is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getTranslationAyah(
            query: anyNamed('query'),
            identifier: anyNamed('identifier'),
          )).thenAnswer((_) async => tAyahModel);

          when(mockLocalDataSource.cacheAyah(any)) // ohterwise missingStub
              .thenAnswer((_) async => true);
          // act
          final result = await repository.getTranslationAyah(
            query: tQuery,
            identifier: tIdentifier,
          );
          // assert
          verify(mockRemoteDataSource.getTranslationAyah(
            query: tQuery,
            identifier: tIdentifier,
          ));
          expect(result, equals(Right(tAyah)));
        },
      );

      test(
        'should cache remote data when the call remote data is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getTranslationAyah(
            query: anyNamed('query'),
            identifier: anyNamed('identifier'),
          )).thenAnswer((_) async => tAyahModel);

          when(mockLocalDataSource.cacheAyah(any))
              .thenAnswer((_) async => true);
          // act
          await repository.getTranslationAyah(
            query: tQuery,
            identifier: tIdentifier,
          );
          // assert
          verify(mockLocalDataSource.cacheAyah(tAyahModel));
        },
      );

      test(
        'should return NoInterFailure when the call remote data source throw SocketException',
        () async {
          // arrange
          when(mockRemoteDataSource.getTranslationAyah(
            query: anyNamed('query'),
            identifier: anyNamed('identifier'),
          )).thenThrow(SocketException('No Internet'));
          // act
          final result = await repository.getTranslationAyah(
            query: tQuery,
            identifier: tIdentifier,
          );
          // assert
          expect(result, equals(Left(NoInternetFailure())));
        },
      );

      test(
        'should return ServerException with proper message when the call remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getTranslationAyah(
            query: anyNamed('query'),
            identifier: anyNamed('identifier'),
          )).thenThrow(ServerException('Server Failure'));
          // act
          final result = await repository.getTranslationAyah(
            query: tQuery,
            identifier: tIdentifier,
          );
          // assert
          expect(result, equals(Left(ServerFailure('Server Failure'))));
        },
      );
    });
  });
}
