// @GenerateMocks([GetArabicAyah, GetTranslationAyah, InputFormatter])
import 'dart:convert';

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

  final json = jsonDecode(fixture('ayah_cached.json'));
  json['type'] = 'quran';
  final tArabicAyah = AyahModel.fromCachedJson(json);
  json['type'] = 'translation';
  final tTranslationAyah = AyahModel.fromCachedJson(json);

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

  group('switchType', () {
    test(
      'should do no more interactions with usecases when state is not [Loaded]',
      () async {
        // arrange
        controller.state.value = Empty();
        // act
        await controller.switchType();
        // assert
        verifyNoMoreInteractions(mockGetArabicAyah);
        verifyNoMoreInteractions(mockGetTranslationAyah);
      },
    );

    group('[Loaded] state', () {
      final json = jsonDecode(fixture('ayah_cached.json'));
      json['type'] = 'quran';
      final tArabicAyah = AyahModel.fromCachedJson(json);
      json['type'] = 'translation';
      final tTranslationAyah = AyahModel.fromCachedJson(json);

      setUp(() {
        setUpMockInputFormatterSuccess();
        when(mockGetArabicAyah(any))
            .thenAnswer((_) async => Right(tArabicAyah));
        when(mockGetTranslationAyah(any))
            .thenAnswer((_) async => Right(tTranslationAyah));
      });

      test(
        'should call GetTranslationAyah when loaded ayah type is "quran"',
        () async {
          // arrange
          controller.state.value = Loaded(tArabicAyah);
          // act
          await controller.switchType();
          // assert
          verify(mockGetTranslationAyah(Params(query: tQuery)));
          verifyNoMoreInteractions(mockGetArabicAyah);
        },
      );
      test(
        'should call GetArabicAyah when loaded ayah type is "translation"',
        () async {
          // arrange
          controller.state.value = Loaded(tTranslationAyah);
          // act
          await controller.switchType();
          // assert
          verify(mockGetArabicAyah(tQuery));
          verifyNoMoreInteractions(mockGetTranslationAyah);
        },
      );
    });
  });

  group('getInvertedAyahType', () {
    test(
      'should return null when the state is not [Loaded]',
      () async {
        // arrange
        controller.state.value = Empty();
        // act
        final result = controller.getInvertedAyahType();
        // assert
        expect(result, null);
      },
    );
    group('state is [Loaded]', () {
      test(
        'should return "${AyahType.TRANSLATION}" when ayah type is "${AyahType.QURAN}"',
        () async {
          // arrange
          controller.state.value = Loaded(tArabicAyah);
          // act
          final result = controller.getInvertedAyahType();
          // assert
          expect(result, AyahType.TRANSLATION);
        },
      );
      test(
        'should return "${AyahType.QURAN}" when ayah type is "${AyahType.TRANSLATION}"',
        () async {
          // arrange
          controller.state.value = Loaded(tTranslationAyah);
          // act
          final result = controller.getInvertedAyahType();
          // assert
          expect(result, AyahType.QURAN);
        },
      );
    });
  });
}
