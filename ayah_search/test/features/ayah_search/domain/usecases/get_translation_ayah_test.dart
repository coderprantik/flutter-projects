import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_translation_ayah.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'ayah_search_repository.mocks.dart';

void main() {
  late GetTranslationAyah usecase;
  late MockAyahSearchRepository mockAyahSearchRepository;

  setUp(() {
    mockAyahSearchRepository = MockAyahSearchRepository();
    usecase = GetTranslationAyah(mockAyahSearchRepository);
  });

  final tQuery = "1:2";
  final tAyah = Ayah(
    surahNumber: 1,
    ayahNumber: 2,
    surahName: "surahName",
    surahNameTranslation: "surahNameTranslation",
    revelationType: "revelationType",
    sajda: false,
    type: "type",
    editionName: "editionName",
    direction: "direction",
    text: "text",
  );

  test(
    'should get translation Ayah for the query from repository',
    () async {
      // arrange
      when(mockAyahSearchRepository.getTranslationAyah(tQuery))
          .thenAnswer((_) async => Right(tAyah));
      // act
      final result = await usecase(tQuery);
      // assert
      expect(result, Right(tAyah));
      verify(mockAyahSearchRepository.getTranslationAyah(tQuery));
      verifyNoMoreInteractions(mockAyahSearchRepository);
    },
  );
}
