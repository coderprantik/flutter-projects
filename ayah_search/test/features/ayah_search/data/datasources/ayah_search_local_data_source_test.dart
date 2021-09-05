import 'dart:convert';

import 'package:ayah_search/core/error/exceptions.dart';
import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_local_data_source.dart';
import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'shared_preferences.mocks.dart';

// @GenerateMocks([SharedPreferences])
void main() {
  late AyahSearchLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = AyahSearchLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  final tQuery = '1:2';
  final tCachedJsonString = fixture('ayah_cached.json');
  final tAyahModel = AyahModel.fromRawJson(
    fixture('ayah_remote.json'),
  ); // this model is same to the model from ayah_cached.json
  final tIdentifier = tAyahModel.identifier;
  final tKey = '${tAyahModel.surahNumber}:${tAyahModel.ayahNumber}';

  group('getArabicAyah', () {
    test(
      'should return Ayah from SharedPreferences when data is present',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(tCachedJsonString);
        // act
        final result = await dataSource.getArabicAyah(query: tQuery);
        // assert
        final expectedKey = tKey;

        expect(result, equals(tAyahModel));
        verify(mockSharedPreferences.getString(expectedKey));
      },
    );

    test(
      'should throw CacheException when data is not present',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getArabicAyah;
        // assert
        expect(
          () => call(query: tQuery),
          throwsA(TypeMatcher<CacheException>()),
        );
      },
    );
  });
  group('getTranslationAyah', () {
    test(
      'should return Ayah from SharedPreferences when data is present',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(tCachedJsonString);
        // act
        final result = await dataSource.getTranslationAyah(
          query: tQuery,
          identifier: tIdentifier,
        );
        // assert
        final expectedKey = '$tKey/$tIdentifier';

        expect(result, equals(tAyahModel));
        verify(mockSharedPreferences.getString(expectedKey));
      },
    );

    test(
      'should throw CacheException when data is not present',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getTranslationAyah;
        // assert
        expect(
          () => call(query: tQuery, identifier: tIdentifier),
          throwsA(TypeMatcher<CacheException>()),
        );
      },
    );
  });

  group('cacheAyah', () {
    test(
      'should call SharedPreferneces to cache the data',
      () async {
        // arrange
        when(mockSharedPreferences.setString(any, any))
            .thenAnswer((_) async => true);
        // act
        final result = await dataSource.cacheAyah(tAyahModel);
        // assert
        final expectedJsonString = tAyahModel.toRawJson();
        String expectedKey = '$tKey/$tIdentifier';

        verify(
          mockSharedPreferences.setString(expectedKey, expectedJsonString),
        );
        expect(result, true);
      },
    );
    test(
      "should call SharedPreferneces to cache the data & type is 'quran'",
      () async {
        // arrange
        when(mockSharedPreferences.setString(any, any))
            .thenAnswer((_) async => true);
        // act
        final cachedJson = tAyahModel.toJson();
        cachedJson['type'] = 'quran';

        final result = await dataSource.cacheAyah(
          AyahModel.fromCachedJson(cachedJson),
        );
        // assert
        String expectedKey = tKey;
        String expectedJsonString = jsonEncode(cachedJson);

        verify(
          mockSharedPreferences.setString(expectedKey, expectedJsonString),
        );
        expect(result, true);
      },
    );
  });
}
