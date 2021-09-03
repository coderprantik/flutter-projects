import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/ayah.dart';

abstract class AyahSearchRepository {
  Future<Either<Failure, Ayah>> getArabicAyah(String query);
  Future<Either<Failure, Ayah>> getTranslationAyah({
   required String query,
   required String identifier,
  });
}
