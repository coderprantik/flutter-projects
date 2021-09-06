import 'dart:io' as io;

import 'package:ayah_search/core/error/exceptions.dart';
import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_remote_data_source.dart';
import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'http_client.mocks.dart';

@GenerateMocks([Client])
void main() {
  late AyahSearchRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = AyahSearchRemoteDataSourceImpl(client: mockClient);
  });

  final endPoint = 'https://api.alquran.cloud/v1/ayah';
  final headers = {'Content-Type': 'application/json'};

  final tQuery = '1:2';
  final jsonString = fixture('ayah_remote.json');
  final tAyahModel = AyahModel.fromRawJson(jsonString);

  void setUpMockClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => Response(
        jsonString,
        200,
        headers: {
          io.HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );
  }

  void setUpMockClientFailure404() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => Response('No data found!', 404),
    );
  }

  group('getArabicAyah', () {
    test(
      '''should perform a GET request on a URL with query
      being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockClientSuccess200();
        // act
        await dataSource.getArabicAyah(query: tQuery);
        // assert
        verify(mockClient.get(
          Uri.parse('$endPoint/$tQuery'),
          headers: headers,
        ));
      },
    );

    test(
      'should return Ayah Model when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockClientSuccess200();
        // act
        final result = await dataSource.getArabicAyah(query: tQuery);
        // assert
        expect(result, equals(tAyahModel));
      },
    );

    test(
      '''should throw a ServerException with message
       when the response code is 404 or other (failure)''',
      () async {
        // arrange
        setUpMockClientFailure404();
        // act
        final call = dataSource.getArabicAyah;
        // assert
        expect(
          () => call(query: tQuery),
          throwsA(TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw SocketException when there is no internet',
      () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$endPoint/$tQuery'),
          headers: anyNamed('headers'),
        )).thenThrow(io.SocketException('No Inernet'));
        // act
        final call = dataSource.getArabicAyah;
        // assert
        expect(
          () => call(query: tQuery),
          throwsA(TypeMatcher<io.SocketException>()),
        );
      },
    );
  });
}
