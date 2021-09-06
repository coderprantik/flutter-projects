import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:dio/dio.dart';

abstract class AyahSearchRemoteDataSource {
  Future<AyahModel> getArabicAyah({
    required String query,
  });

  Future<AyahModel> getTranslationAyah({
    required String query,
    required String identifier,
  });
}

class AyahSearchRemoteDataSourceImpl implements AyahSearchRemoteDataSource {
  final Dio client;

  AyahSearchRemoteDataSourceImpl({required this.client});

  @override
  Future<AyahModel> getArabicAyah({required String query}) {
    // TODO: implement getArabicAyah
    throw UnimplementedError();
  }

  @override
  Future<AyahModel> getTranslationAyah(
      {required String query, required String identifier}) {
    // TODO: implement getTranslationAyah
    throw UnimplementedError();
  }
}
