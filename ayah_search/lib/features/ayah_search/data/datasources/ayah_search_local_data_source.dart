import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';

abstract class AyahSearchLocalDataSource {
  Future<AyahModel> getArabicAyah(String query);

  Future<AyahModel> getTranslationAyah({
    required String query,
    required String identifier,
  });

  Future<void> cacheAyah(AyahModel ayahModel);

  Future<bool> hasAyah(String query);
}
