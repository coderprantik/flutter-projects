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

  AyahSearchController({
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
    final failureOrString = _inputFormatter.format(input);

    failureOrString.fold(
      (failure) => state.value = Error(MESSAGE.INVALID_INPUT),
      (query) {},
    );
  }

  Future<void> getTranslationAyah() async {}
}

class MESSAGE {
  static const INVALID_INPUT =
      'Please specify a valid surah reference in the format Surah:Ayat (2:255)';
}
