import 'package:ayah_search/core/utils/input_formatter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputFormatter inputFormatter;

  setUp(() {
    inputFormatter = InputFormatter();
  });

  test(
    'should return a formatted string when the input contains at least 2 number',
    () async {
      // arrange
      final input = '01:2.9';
      // act
      final result = inputFormatter.format(input);
      // assert
      expect(result, Right('1:2'));
    },
  );

  test(
    'should return Failure when the input contain less than 2 number',
    () async {
      // arrange
      final input = '1';
      // act
      final result = inputFormatter.format(input);
      // assert
      expect(result, Left(InvalidInputFailure()));
    },
  );

  test(
    'should return formatted string even the input contains negative number',
    () async {
      // arrange
      final input = '-1:02';
      // act
      final result = inputFormatter.format(input);
      // assert
      expect(result, Right('1:2'));
    },
  );
}
