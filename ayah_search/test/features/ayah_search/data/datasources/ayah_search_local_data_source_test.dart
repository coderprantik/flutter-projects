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

  group('getArabicAyah', () {
    final tKey = '${tAyahModel.surahNumber}:${tAyahModel.ayahNumber}';
    test(
      'should return Ayah from SharedPreferences when data is present',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(tCachedJsonString);
        // act
        final result = await dataSource.getArabicAyah(query: tQuery);
        // assert
        expect(result, equals(tAyahModel));
        verify(mockSharedPreferences.getString(tKey));
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
    final tKey =
        '${tAyahModel.surahNumber}:${tAyahModel.ayahNumber}/$tIdentifier';
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
        expect(result, equals(tAyahModel));
        verify(mockSharedPreferences.getString(tKey));
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
}
