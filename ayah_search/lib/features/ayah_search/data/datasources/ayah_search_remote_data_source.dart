import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../models/ayah_model.dart';

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
  Future<AyahModel> getArabicAyah({required String query}) {
    return _getAyah(Uri.parse('$_endPoint/$query'));
  }

  @override
  Future<AyahModel> getTranslationAyah({
    required String query,
    required String identifier,
  }) {
    return _getAyah(Uri.parse('$_endPoint/$query/$identifier'));
  }

  Future<AyahModel> _getAyah(Uri uri) async {
    final response = await client.get(uri, headers: _headers);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return AyahModel.fromJson(json);
    } else if (response.statusCode == 404) {
      throw ServerException(json['data']);
    } else {
      throw ServerException(response.reasonPhrase ?? 'Something went wrong!');
    }
  }
}
