import 'dart:convert';

import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tAyahModel = AyahModel(
    surahNumber: 1,
    ayahNumber: 2,
    surahName: "surahName",
    surahNameTranslation: "surahNameTranslation",
    revelationType: "revelationType",
    sajda: false,
    identifier: 'identifier',
    type: "type",
    editionName: "editionName",
    direction: "direction",
    text: "text",
  );
  final cachedJsonString = fixture('ayah_cached.json');
  final remoteJsonString = fixture('ayah_remote.json');

  test(
    'should be a sub class of Ayah entity',
    () async {
      // assert
      expect(tAyahModel, isA<Ayah>());
    },
  );

  group('fromJson', () {
    final jsonMap = jsonDecode(remoteJsonString);

    test(
      'should return a valid model from JSON Map',
      () async {
        // act
        final result = AyahModel.fromJson(jsonMap);
        // assert
        expect(result, tAyahModel);
      },
    );

    test(
      'should return a valid model from Raw JSON',
      () async {
       // act
        final result = AyahModel.fromRawJson(remoteJsonString);
        // assert
        expect(result, tAyahModel);
      },
    );
  });
}
