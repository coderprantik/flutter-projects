import 'package:equatable/equatable.dart';

class Ayah extends Equatable {
  Ayah({
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahName,
    required this.surahNameTranslation,
    required this.revelationType,
    required this.sajda,
    required this.type,
    required this.editionName,
    required this.direction,
    required this.text,
  });

  final int surahNumber;
  final int ayahNumber;
  final String surahName;
  final String surahNameTranslation;
  final String revelationType;
  final bool sajda;
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
        type,
        editionName,
        direction,
        text,
      ];
}
