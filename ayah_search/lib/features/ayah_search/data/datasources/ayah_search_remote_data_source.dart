import 'package:ayah_search/core/error/exceptions.dart';
import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:http/http.dart';

abstract class AyahSearchRemoteDataSource {
  Future<AyahModel> getArabicAyah({
    required String query,
  });

  Future<AyahModel> getTranslationAyah({
    required String query,
    required String identifier,
  });
}

class AyahSearchRemoteDataSourceImpl implements AyahSearchRemoteDataSource {
  final Client client;
  final _endPoint = 'https://api.alquran.cloud/v1/ayah';
  final _headers = {'Content-Type': 'application/json'};

  AyahSearchRemoteDataSourceImpl({required this.client});

  @override
  Future<AyahModel> getArabicAyah({required String query}) async {
    final response = await client.get(
      Uri.parse('$_endPoint/$query'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return AyahModel.fromRawJson(response.body);
    } else if (response.statusCode == 404) {
      throw ServerException(response.body);
    } else {
      throw ServerException(response.reasonPhrase ?? 'Something went wrong!');
    }
  }

  @override
  Future<AyahModel> getTranslationAyah(
      {required String query, required String identifier}) {
    // TODO: implement getTranslationAyah
    throw UnimplementedError();
  }
}
