// @GenerateMocks([GetArabicAyah, GetTranslationAyah, InputFormatter])
import 'package:ayah_search/core/error/failures.dart';
import 'package:ayah_search/core/utils/input_formatter.dart';
import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_translation_ayah.dart';
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

  void runTestsWhenInputIsValid(Function() body) {
    group('Input is valid', () {
      setUp(
        () => when(mockInputFormatter.format(any)).thenReturn(Right(tQuery)),
      );

      body();
    });
  }

  void setUpMockInputFormatterSuccess() {
    when(mockInputFormatter.format(any)).thenReturn(Right(tQuery));
  }

  void setUpMockInputFormatterFailed() {
    when(mockInputFormatter.format(any)).thenReturn(
      Left(InvalidInputFailure()),
    );
  }

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
    void setUpMockGetArabicAyahSuccess() {
      when(mockGetArabicAyah(any)).thenAnswer((_) async => Right(tAyah));
    }

    void setUpMockGetArabicAyahFailed() {
      when(mockGetArabicAyah(any)).thenAnswer(
        (_) async => Left(CacheFailure()),
      );
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
      'should show [Error] state when the input is invalid with proper message',
      () async {
        // arrange
        setUpMockInputFormatterFailed();
        // act
        await controller.getArabicAyah();
        // assert
        expect(controller.state.value, equals(Error(MESSAGE.INVALID_INPUT)));
      },
    );

    runTestsWhenInputIsValid(() {
      test(
        'should get data from GetArabicAyah usecase',
        () async {
          // arrange
          setUpMockGetArabicAyahSuccess();
          // act
          await controller.getArabicAyah();
          // assert
          verify(mockGetArabicAyah(tQuery));
        },
      );

      test(
        'should show [Loading, Loaded] states when data is gotten successfully',
        () async {
          // arrange
          setUpMockGetArabicAyahSuccess();
          // act
          final result = [];
          controller.state.listen((state) => result.add(state));
          await controller.getArabicAyah();
          // assert
          final expected = [Loading(), Loaded(tAyah)];

          expect(result, expected);
        },
      );
      test(
        '''should show [Loading, Error] states with message
      when getting data is failed''',
        () async {
          // arrange
          setUpMockGetArabicAyahFailed();
          // act
          final result = [];
          controller.state.listen((state) => result.add(state));
          await controller.getArabicAyah();
          // assert
          final expected = [Loading(), Error(MESSAGE.CACHE_FAILURE)];

          expect(result, expected);
        },
      );
    });
  });

  group('getTranslationAyah', () {
    void setUpMockGetTranslationAyahSuccess() {
      when(mockGetTranslationAyah(any)).thenAnswer(
        (_) async => Right(tAyah),
      );
    }

    void setUpMockGetTranslationAyahFailed() {
      when(mockGetTranslationAyah(any)).thenAnswer(
        (_) async => Left(CacheFailure()),
      );
    }

    test(
      'should call InputFormatter to validate & format the input',
      () async {
        setUpMockInputFormatterSuccess();
        setUpMockGetTranslationAyahSuccess();
        // act
        await controller.getTranslationAyah();
        // assert
        verify(mockInputFormatter.format(tQuery));
      },
    );
    test(
      'should show [Error] state when the input is invalid with proper message',
      () async {
        // arrange
        setUpMockInputFormatterFailed();
        // act
        await controller.getTranslationAyah();
        // assert
        expect(controller.state.value, equals(Error(MESSAGE.INVALID_INPUT)));
      },
    );

    runTestsWhenInputIsValid(() {
      test(
        'should get data from GetTranslationAyah usecase',
        () async {
          // arrange
          setUpMockGetTranslationAyahSuccess();
          // act
          await controller.getTranslationAyah();
          // assert
          verify(mockGetTranslationAyah(Params(query: tQuery)));
        },
      );

      test(
        'should show [Loading, Loaded] states when data is gotten successfully',
        () async {
          // arrange
          setUpMockGetTranslationAyahSuccess();
          // act
          final result = [];
          controller.state.listen((state) => result.add(state));
          await controller.getTranslationAyah();
          // assert
          final expected = [Loading(), Loaded(tAyah)];

          expect(result, expected);
        },
      );
      test(
        '''should show [Loading, Error] states with message
      when getting data is failed''',
        () async {
          // arrange
          setUpMockGetTranslationAyahFailed();
          // act
          final result = [];
          controller.state.listen((state) => result.add(state));
          await controller.getTranslationAyah();
          // assert
          final expected = [Loading(), Error(MESSAGE.CACHE_FAILURE)];

          expect(result, expected);
        },
      );
    });
  });
}
