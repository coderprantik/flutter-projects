import 'package:ayah_search/core/error/failures.dart';
import 'package:ayah_search/core/utils/input_formatter.dart';
import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_arabic_ayah.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_translation_ayah.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'ayah_search_state.dart';

class AyahSearchController extends GetxController {
  late GetArabicAyah _getArabicAyah;
  late GetTranslationAyah _getTranslationAyah;
  late InputFormatter _inputFormatter;

  void init({
    required GetArabicAyah getArabicAyah,
    required GetTranslationAyah getTranslationAyah,
    required InputFormatter inputFormatter,
  }) {
    _getArabicAyah = getArabicAyah;
    _getTranslationAyah = getTranslationAyah;
    _inputFormatter = inputFormatter;
  }

  final textEditingController = TextEditingController();
  String get input => textEditingController.text;

  final Rx<AyahSearchState> state = Rx(Empty());

  Future<void> getArabicAyah() async {
    final failureOrQuery = _inputFormatter.format(input);

    await failureOrQuery.fold(
      (failure) async => state.value = Error(MESSAGE.INVALID_INPUT),
      (query) async {
        state.value = Loading();
        final ayah = await _getArabicAyah(query);
        ayah.fold(
          (failure) => state.value = Error(_getMessage(failure)),
          (ayah) => state.value = Loaded(ayah),
        );
      },
    );
  }

  Future<void> getTranslationAyah() async {}

  _getMessage(Failure failure) {
    if (failure is ServerFailure)
      return failure.message;
    else if (failure is CacheFailure)
      return MESSAGE.CACHE_FAILURE;
    else if (failure is NoInternetFailure)
      return MESSAGE.NO_INTERNET;
    else if (failure is InvalidInputFailure)
      return MESSAGE.INVALID_INPUT;
    else
      return 'Unexpected failure!';
  }
}

class MESSAGE {
  static const INVALID_INPUT =
      'Please specify a valid surah reference in the format Surah:Ayat (2:255)';
  static const NO_INTERNET = 'No Internet! Please connect to internet';
  static const CACHE_FAILURE = 'No data found in local cache';
}
