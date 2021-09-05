import 'dart:convert';

import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';

class AyahModel extends Ayah {
  AyahModel({
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahName,
    required this.surahNameTranslation,
    required this.revelationType,
    required this.sajda,
    required this.identifier,
    required this.type,
    required this.editionName,
    required this.direction,
    required this.text,
  }) : super(
          surahNumber: surahNumber,
          ayahNumber: ayahNumber,
          surahName: surahName,
          surahNameTranslation: surahNameTranslation,
          revelationType: revelationType,
          sajda: sajda,
          type: type,
          editionName: editionName,
          direction: direction,
          text: text,
        );

  final int surahNumber;
  final int ayahNumber;
  final String surahName;
  final String surahNameTranslation;
  final String revelationType;
  final bool sajda;
  final String identifier;
  final String type;
  final String editionName;
  final String direction;
  final String text;

  @override
  List<Object?> get props => [
        surahNumber,
        ayahNumber,
        surahName,
        surahNameTranslation,
        revelationType,
        sajda,
        identifier,
        type,
        editionName,
        direction,
        text,
      ];

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    json = json['data'];
    final surah = json['surah'];
    final edition = json['edition'];

    return AyahModel(
      surahNumber: surah['number'],
      ayahNumber: json['numberInSurah'],
      surahName: surah['englishName'],
      surahNameTranslation: surah['englishNameTranslation'],
      revelationType: surah['revelationType'],
      sajda: json['sajda'],
      identifier: edition['identifier'],
      type: edition['type'],
      editionName: edition['englishName'],
      direction: edition['direction'],
      text: json['text'],
    );
  }

  factory AyahModel.fromRawJson(String jsonString) {
    return AyahModel.fromJson(json.decode(jsonString));
  }

  factory AyahModel.fromCachedJson(Map<String, dynamic> json) {
    return AyahModel(
      surahNumber: json['surahNumber'],
      ayahNumber: json['ayahNumber'],
      surahName: json['surahName'],
      surahNameTranslation: json['surahNameTranslation'],
      revelationType: json['revelationType'],
      sajda: json['sajda'],
      identifier: json['identifier'],
      type: json['type'],
      editionName: json['editionName'],
      direction: json['direction'],
      text: json['text'],
    );
  }

  factory AyahModel.fromCachedRawJson(String jsonString) {
    return AyahModel.fromCachedJson(jsonDecode(jsonString));
  }

  Map<String, dynamic> toJson() {
    return {
      "surahNumber": surahNumber,
      "ayahNumber": ayahNumber,
      "surahName": surahName,
      "surahNameTranslation": surahNameTranslation,
      "revelationType": revelationType,
      "sajda": sajda,
      "identifier": identifier,
      "type": type,
      "editionName": editionName,
      "text": text,
      "direction": direction,
    };
  }

  String toRawJson() => jsonEncode(toJson());
}
