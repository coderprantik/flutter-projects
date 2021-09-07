import 'package:ayah_search/core/network/network_info.dart';
import 'package:ayah_search/core/utils/input_formatter.dart';
import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_local_data_source.dart';
import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_remote_data_source.dart';
import 'package:ayah_search/features/ayah_search/data/repositories/ayah_search_repository_impl.dart';
import 'package:ayah_search/features/ayah_search/domain/repositories/ayah_search_repository.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_arabic_ayah.dart';
import 'package:ayah_search/features/ayah_search/domain/usecases/get_translation_ayah.dart';
import 'package:connection_checker/connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setUp() async {
  // Usecases
  locator.registerLazySingleton(() => GetArabicAyah(locator()));
  locator.registerLazySingleton(() => GetTranslationAyah(locator()));

  // Repository
  locator.registerLazySingleton<AyahSearchRepository>(
    () => AyahSearchRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Data sources
  locator.registerLazySingleton<AyahSearchRemoteDataSource>(
    () => AyahSearchRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<AyahSearchLocalDataSource>(
    () => AyahSearchLocalDataSourceImpl(sharedPreferences: locator()),
  );

  // Cores
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
  locator.registerLazySingleton(() => InputFormatter());

  // External
  locator.registerLazySingleton(() => ConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);

  locator.registerLazySingleton(() => Client());
}
