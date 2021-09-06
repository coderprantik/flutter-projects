import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_arabic_ayah.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_translation_ayah.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'ayah_search_state.dart';

class AyahSearchController extends GetxController {
  late GetArabicAyah _getArabicAyah;
  late GetTranslationAyah _getTranslationAyah;

  AyahSearchController({
    required GetArabicAyah getArabicAyah,
    required GetTranslationAyah getTranslationAyah,
  }) {
    _getArabicAyah = getArabicAyah;
    _getTranslationAyah = getTranslationAyah;
  }

  final state = Rx(Empty());

  Future<void> getArabicAyah({required String query}) async {}

  Future<void> getTranslationAyah(String query) async {}
}
