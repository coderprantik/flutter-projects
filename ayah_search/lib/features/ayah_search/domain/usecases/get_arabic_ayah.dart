import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/ayah.dart';
import '../repositories/ayah_search_repository.dart';

class GetArabicAyah {
  final AyahSearchRepository repository;

  GetArabicAyah(this.repository);

  Future<Either<Failure, Ayah>> call(String query) async {
    return await repository.getArabicAyah(query);
  }
}
