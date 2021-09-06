import 'package:ayah_search/core/utils/input_formatter.dart';
import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_arabic_ayah.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_translation_ayah.dart';
import 'package:equatable/equatable.dart';
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

  final state = Rx(Empty());

  Future<void> getArabicAyah({required String query}) async {}

  Future<void> getTranslationAyah(String query) async {}
}
