import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/features/ayah_search/domain/repositories/ayah_search_repository.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_arabic_ayah.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ayah_search_repository.mocks.dart';

@GenerateMocks([AyahSearchRepository])
void main() {
  late GetArabicAyah usecase;
  late MockAyahSearchRepository mockAyahSearchRepository;

  setUp(() {
    mockAyahSearchRepository = MockAyahSearchRepository();
    usecase = GetArabicAyah(mockAyahSearchRepository);
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
    'should get arabic Ayah for the query from repository',
    () async {
      // arrange
      when(mockAyahSearchRepository.getArabicAyah(any))
          .thenAnswer((_) async => Right(tAyah));
      // act
      final result = await usecase(tQuery);
      // assert
      expect(result, Right(tAyah));
      verify(mockAyahSearchRepository.getArabicAyah(tQuery));
      verifyNoMoreInteractions(mockAyahSearchRepository);
    },
  );
}
