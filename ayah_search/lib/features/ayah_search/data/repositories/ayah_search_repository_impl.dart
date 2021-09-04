import 'package:ayah_search/core/error/exceptions.dart';
import 'package:ayah_search/core/network/network_info.dart';
import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_local_data_source.dart';
import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_remote_data_source.dart';
import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/core/error/failures.dart';
import 'package:ayah_search/features/ayah_search/domain/repositories/ayah_search_repository.dart';
import 'package:dartz/dartz.dart';

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
    if (await localDataSource.hasAyah(query)) {
      try {
        final ayah = await localDataSource.getArabicAyah(query);
        return Right(ayah);
      } on CacheException {
        print('localDataSource.getArabicAyah: CacheException');
      }
    } else {
      if (await networkInfo.hasConnection) {
        try {
          final ayah = await remoteDataSource.getArabicAyah(query);
          localDataSource.cacheAyah(ayah);
          return Right(ayah);
        } on ServerException {
          return Left(ServerFailure());
        }
      }
    }
    return Left(CacheFailure());
  }

  @override
  Future<Either<Failure, Ayah>> getTranslationAyah(
      {required String query, required String identifier}) async {
    if (await localDataSource.hasAyah(query)) {
      final ayah = await localDataSource.getTranslationAyah(
        query: query,
        identifier: identifier,
      );
      return Right(ayah);
    }

    // return a mock Ayah
    return Right(Ayah(
      surahNumber: 1,
      ayahNumber: 2,
      surahName: "surahName",
      surahNameTranslation: 'surahNameTranslation',
      revelationType: 'revelationType',
      sajda: false,
      type: 'type',
      editionName: 'editionName',
      direction: 'direction',
      text: 'text',
    ));
  }
}
