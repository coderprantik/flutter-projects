import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/repositories/ayah_search_repository.dart';
import '../datasources/ayah_search_local_data_source.dart';
import '../datasources/ayah_search_remote_data_source.dart';
import '../models/ayah_model.dart';

typedef Future<AyahModel> GetAyah();

class AyahSearchRepositoryImpl implements AyahSearchRepository {
  final AyahSearchRemoteDataSource remoteDataSource;
  final AyahSearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AyahSearchRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Ayah>> getArabicAyah(String query) async {
    return _getAyah(
      local: () => localDataSource.getArabicAyah(query),
      remote: () => remoteDataSource.getArabicAyah(query),
      query: query,
    );
  }

  @override
  Future<Either<Failure, Ayah>> getTranslationAyah(
      {required String query, required String identifier}) async {
    return _getAyah(
      local: () => localDataSource.getTranslationAyah(
        query: query,
        identifier: identifier,
      ),
      remote: () => remoteDataSource.getTranslationAyah(
        query: query,
        identifier: identifier,
      ),
      query: query,
    );
  }

  Future<Either<Failure, Ayah>> _getAyah({
    required GetAyah local,
    required GetAyah remote,
    required String query,
  }) async {
    if (await localDataSource.hasAyah(query)) {
      try {
        final ayah = await local();
        return Right(ayah);
      } on CacheException {
        print('getTranslationAyah: CacheException');
      }
    } else if (await networkInfo.hasConnection) {
      try {
        final ayah = await remote();
        localDataSource.cacheAyah(ayah);
        return Right(ayah);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(CacheFailure());
  }
}
