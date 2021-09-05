import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AyahSearchLocalDataSource {
  Future<AyahModel> getArabicAyah({
    required String query,
  });

  Future<AyahModel> getTranslationAyah({
    required String query,
    required String identifier,
  });

  Future<bool> cacheAyah(AyahModel ayahModel);
}

class AyahSearchLocalDataSourceImpl implements AyahSearchLocalDataSource {
  final SharedPreferences sharedPreferences;

  AyahSearchLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheAyah(AyahModel ayahModel) {
    // TODO: implement cacheAyah
    throw UnimplementedError();
  }

  @override
  Future<AyahModel> getArabicAyah({required String query}) {
    // TODO: implement getArabicAyah
    throw UnimplementedError();
  }

  @override
  Future<AyahModel> getTranslationAyah({required String query, required String identifier}) {
    // TODO: implement getTranslationAyah
    throw UnimplementedError();
  }

}
