import 'dart:io';

import 'package:ayah_search/core/error/exceptions.dart';
import 'package:ayah_search/core/network/network_info.dart';
import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_local_data_source.dart';
import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_remote_data_source.dart';
import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/core/error/failures.dart';
import 'package:ayah_search/features/ayah_search/domain/repositories/ayah_search_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<AyahModel> _GetAyah();

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
  Future<Either<Failure, Ayah>> getArabicAyah({required String query}) async {
    return _getAyah(
      local: () => localDataSource.getArabicAyah(query: query),
      remote: () => remoteDataSource.getArabicAyah(query: query),
    );
  }

  @override
  Future<Either<Failure, Ayah>> getTranslationAyah(
      {required String query, required String identifier}) {
    return _getAyah(
      local: () => localDataSource.getTranslationAyah(
        query: query,
        identifier: identifier,
      ),
      remote: () => remoteDataSource.getTranslationAyah(
        query: query,
        identifier: identifier,
      ),
    );
  }

  Future<Either<Failure, Ayah>> _getAyah({
    required _GetAyah local,
    required _GetAyah remote,
  }) async {
    try {
      final ayahModel = await local();
      return Right(ayahModel);
    } on CacheException {
      try {
        final ayahModel = await remote();
        localDataSource.cacheAyah(ayahModel);
        return Right(ayahModel);
      } on SocketException {
        return Left(NoInternetFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
  }
}
