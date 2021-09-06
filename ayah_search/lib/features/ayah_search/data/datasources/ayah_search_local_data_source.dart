
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/ayah_model.dart';

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
  Future<AyahModel> getArabicAyah({required String query}) => _getAyah(query);

  @override
  Future<AyahModel> getTranslationAyah({
    required String query,
    required String identifier,
  }) {
    return _getAyah('$query/$identifier');
  }

  @override
  Future<bool> cacheAyah(AyahModel ayahModel) async {
    String key = '${ayahModel.surahNumber}:${ayahModel.ayahNumber}';
    if (ayahModel.type != 'quran') key = '$key/${ayahModel.identifier}';

    final jsonString = ayahModel.toRawJson();

    return await sharedPreferences.setString(key, jsonString);
  }

  Future<AyahModel> _getAyah(String key) async {
    final jsonString = sharedPreferences.getString(key);

    if (jsonString == null) throw CacheException();

    return AyahModel.fromCachedRawJson(jsonString);
  }
}
