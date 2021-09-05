import 'dart:convert';

import 'package:ayah_search/core/error/exceptions.dart';
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
  Future<AyahModel> getArabicAyah({required String query}) => _getAyah(query);

  @override
  Future<AyahModel> getTranslationAyah({
    required String query,
    required String identifier,
  }) {
    return _getAyah('$query/$identifier');
  }

  @override
  Future<bool> cacheAyah(AyahModel ayahModel) {
    // TODO: implement cacheAyah
    throw UnimplementedError();
  }

  Future<AyahModel> _getAyah(String key) async {
    final jsonString = sharedPreferences.getString(key);

    if (jsonString == null) throw CacheException();

    final Map<String, dynamic> json = jsonDecode(jsonString);

    return AyahModel(
      surahNumber: json['surahNumber'],
      ayahNumber: json['ayahNumber'],
      surahName: json['surahName'],
      surahNameTranslation: json['surahNameTranslation'],
      revelationType: json['revelationType'],
      sajda: json['sajda'],
      identifier: json['identifier'],
      type: json['type'],
      editionName: json['editionName'],
      direction: json['direction'],
      text: json['text'],
    );
  }
}
