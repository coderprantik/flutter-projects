// @GenerateMocks([GetArabicAyah, GetTranslationAyah, InputFormatter])
import 'package:ayah_search/core/utils/input_formatter.dart';
import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
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
  late MockInputFormatter mockInputFormatter;

  setUp(() {
    mockGetArabicAyah = MockGetArabicAyah();
    mockGetTranslationAyah = MockGetTranslationAyah();
    mockInputFormatter = MockInputFormatter();
    // setuping controller
    Get.lazyPut(() => AyahSearchController());
    controller = Get.find<AyahSearchController>();
    controller.init(
      getArabicAyah: mockGetArabicAyah,
      getTranslationAyah: mockGetTranslationAyah,
      inputFormatter: mockInputFormatter,
    );
  });

  final tQuery = '1:2';
  final tAyah = AyahModel.fromRawJson(fixture('ayah_remote.json'));

  test(
    'should state be Empty at intial',
    () async {
      // act
      final state = controller.state.value;
      // assert
      expect(state, isA<Empty>());
    },
  );

  /// set [textEditingController]'s text = tQuery
  setUp(() => controller.textEditingController.text = tQuery);

  group('getArabicAyah', () {
    void setUpMockInputFormatterSuccess() {
      when(mockInputFormatter.format(any)).thenReturn(Right(tQuery));
    }

    void setUpMockInputFormatterFailed() {
      when(mockInputFormatter.format(any)).thenReturn(
        Left(InvalidInputFailure()),
      );
    }

    void setUpMockGetArabicAyahSuccess() {
      when(mockGetArabicAyah(any)).thenAnswer((_) async => Right(tAyah));
    }

    test(
      'should call InputFormatter to validate & format the input',
      () async {
        setUpMockInputFormatterSuccess();
        setUpMockGetArabicAyahSuccess();
        // act
        await controller.getArabicAyah();
        // assert
        verify(mockInputFormatter.format(tQuery));
      },
    );
    test(
      'should emit [Error] state when the input is invalid with proper message',
      () async {
        // arrange
        setUpMockInputFormatterFailed();
        // act
        await controller.getArabicAyah();
        // assert
        expect(controller.state.value, equals(Error(MESSAGE.INVALID_INPUT)));
      },
    );
    test(
      'should get data from GetArabicAyah usecase',
      () async {
        // arrange
        setUpMockInputFormatterSuccess();
        setUpMockGetArabicAyahSuccess();
        // act
        await controller.getArabicAyah();
        // assert
        verify(mockGetArabicAyah(tQuery));
      },
    );
  });
}
