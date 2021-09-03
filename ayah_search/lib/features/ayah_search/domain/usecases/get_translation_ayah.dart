import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ayah.dart';
import '../repositories/ayah_search_repository.dart';

class GetTranslationAyah implements Usecase<Ayah, Params> {
  final AyahSearchRepository repository;

  GetTranslationAyah(this.repository);

  @override
  Future<Either<Failure, Ayah>> call(Params params) async {
    return await repository.getTranslationAyah(
      query: params.query,
      identifier: params.identifier,
    );
  }
}

const String IDENTIFIER_BN = "bn.bengali";

class Params extends Equatable {
  final String query;
  final String identifier;

  Params({
    required this.query,
    this.identifier: IDENTIFIER_BN,
  });

  @override
  List<Object?> get props => [query, identifier];
}
