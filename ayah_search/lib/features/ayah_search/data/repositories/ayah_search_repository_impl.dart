import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/core/error/failures.dart';
import 'package:ayah_search/features/ayah_search/domain/repositories/ayah_search_repository.dart';
import 'package:dartz/dartz.dart';

class AyahSearchRepositoryImpl implements AyahSearchRepository {
  @override
  Future<Either<Failure, Ayah>> getArabicAyah(String query) {
    // TODO: implement getArabicAyah
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Ayah>> getTranslationAyah({required String query, required String identifier}) {
    // TODO: implement getTranslationAyah
    throw UnimplementedError();
  }

}