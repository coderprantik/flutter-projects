import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/repositories/ayah_search_repository.dart';
import '../datasources/ayah_search_local_data_source.dart';
import '../datasources/ayah_search_remote_data_source.dart';
import '../models/ayah_model.dart';

typedef Future<AyahModel> _GetAyah();

class AyahSearchRepositoryImpl implements AyahSearchRepository {
  final AyahSearchRemoteDataSource remoteDataSource;
  final AyahSearchLocalDataSource localDataSource;

  AyahSearchRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
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
