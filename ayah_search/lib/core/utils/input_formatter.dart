import 'package:ayah_search/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputFormatter {
  final _regexp = RegExp(r'\+?(\d+(\.(\d+)?)?|\.\d+)');

  bool validate(String input) => _regexp.allMatches(input).length >= 2;

  Either<Failure, String> format(String input) {
    if (!validate(input)) return Left(InvalidInputFailure());

    final matches = _regexp.allMatches(input).toList();

    return Right(
      '${_intFromMatch(matches[0])}:${_intFromMatch(matches[1])}',
    );
  }

  int _intFromMatch(RegExpMatch match) {
    return num.parse(match.input.substring(match.start, match.end)).floor();
  }
}

class InvalidInputFailure extends Failure {}
