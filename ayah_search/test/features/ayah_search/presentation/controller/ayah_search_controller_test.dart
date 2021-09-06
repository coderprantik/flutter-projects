// @GenerateMocks([GetArabicAyah, GetTranslationAyah])
import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/features/ayah_search/presentation/controller/ayah_search_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'ayah_search_controller.mocks.dart';

void main() {
  late AyahSearchController controller;
  late MockGetArabicAyah mockGetArabicAyah;
  late MockGetTranslationAyah mockGetTranslationAyah;

  setUp(() {
    mockGetArabicAyah = MockGetArabicAyah();
    mockGetTranslationAyah = MockGetTranslationAyah();
    // setuping controller
    Get.lazyPut(() => AyahSearchController(
          getArabicAyah: mockGetArabicAyah,
          getTranslationAyah: mockGetTranslationAyah,
        ));
    controller = Get.find<AyahSearchController>();
  });

  final tQuery = '1:2';
  final Ayah tAyah = AyahModel.fromRawJson(fixture('ayah_remote.json'));

  test(
    'should state be Empty at intial',
    () async {
      // act
      final state = controller.state.value;
      // assert
      expect(state, isA<Empty>());
    },
  );

  group('getArabicAyah', () {
    test(
      'should get data from getArabicAyah usecase',
      () async {
        // arrange
        when(mockGetArabicAyah(any)).thenAnswer((_) async => Right(tAyah));
        // act
        final result = await controller.getArabicAyah(query: tQuery);
        // assert
      },
    );
  });
}
