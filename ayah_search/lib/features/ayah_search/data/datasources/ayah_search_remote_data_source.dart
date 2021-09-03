import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';

abstract class AyahSearchRemoteDataSource {
  Future<AyahModel> getArabicAyah(String query);

  Future<AyahModel> getTranslationAyah({
    required String query,
    required String identifier,
  });
}
