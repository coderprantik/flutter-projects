import 'package:ayah_search/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/ayah.dart';
import '../repositories/ayah_search_repository.dart';

class GetArabicAyah implements Usecase<Ayah, String> {
  final AyahSearchRepository repository;

  GetArabicAyah(this.repository);

  Future<Either<Failure, Ayah>> call(String query) async {
    return await repository.getArabicAyah(query);
  }
}
