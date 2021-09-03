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
  final cachedrawJson = fixture('ayah_cached.json');
  final remoteRawJson = fixture('ayah_remote.json');

  test(
    'should AyahModel be a sub class of Ayah',
    () async {
      // assert
      expect(tAyahModel, isA<Ayah>());
    },
  );

  group('fromJson', () {
    final json = jsonDecode(remoteRawJson);

    test(
      'should return AyahModel from JSON Map',
      () async {
        // act
        final result = AyahModel.fromJson(json);
        // assert
        expect(result, tAyahModel);
      },
    );

    test(
      'should return AyahModel from Raw JSON',
      () async {
        // arrange

        // act
        final result = AyahModel.fromRawJson(remoteRawJson);
        // assert
        expect(result, tAyahModel);
      },
    );
  });
}
