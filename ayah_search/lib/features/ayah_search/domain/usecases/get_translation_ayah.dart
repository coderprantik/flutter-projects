import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ayah.dart';
import '../repositories/ayah_search_repository.dart';

class GetTranslationAyah implements Usecase<Ayah, String> {
  final AyahSearchRepository repository;

  GetTranslationAyah(this.repository);

  @override
  Future<Either<Failure, Ayah>> call(String query) async {
    return await repository.getTranslationAyah(query);
  }
}
