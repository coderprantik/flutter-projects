import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/ayah.dart';

abstract class AyahSearchRepository {
  Future<Either<Failure, Ayah>> getArabicAyah(String query);
  Future<Either<Failure, Ayah>> getTranslationAyah({
   required String query,
   required String identifier,
  });
}
