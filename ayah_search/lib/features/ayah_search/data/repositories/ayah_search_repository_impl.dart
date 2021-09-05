import 'dart:io';

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
  Future<Either<Failure, Ayah>> getArabicAyah({required String query}) async {
    try {
      final ayahModel = await localDataSource.getArabicAyah(query: query);
      return Right(ayahModel);
    } on CacheException {
      try {
        final ayahModel = await remoteDataSource.getArabicAyah(query: query);
        localDataSource.cacheAyah(ayahModel);
        return Right(ayahModel);
      } on SocketException {
        return Left(NoInternetFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Ayah>> getTranslationAyah(
      {required String query, required String identifier}) {
    // TODO: implement getTranslationAyah
    throw UnimplementedError();
  }
}
