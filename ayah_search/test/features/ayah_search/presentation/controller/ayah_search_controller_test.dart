// @GenerateMocks([GetArabicAyah, GetTranslationAyah])
import 'package:ayah_search/features/ayah_search/presentation/controller/ayah_search_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

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
}
