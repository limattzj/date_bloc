import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Date nextBday;
  Date firstBday;

  setUp(() {
    nextBday = Date(
      message: "Martin's next bday",
      targetDate: DateTime.parse('2021-01-24'),
    );

    firstBday = Date(
      message: "Martin's first bday",
      targetDate: DateTime.parse('1994-01-24'),
    );
  });

  group('targetDate is in the future', () {
    test('should return 265 2020-05-04', () async {
      // arrange
      final DateTime startDate = DateTime.parse('2020-05-04');
      final result = nextBday.getDaysDifference(
        startDate,
        nextBday.targetDate,
      );
      // assert
      expect(result, 265);
    });
    test('should return 265 from 2020-05-04 18:04:00', () async {
      // arrange
      final DateTime startDate = DateTime.parse('2020-05-04 18:04:00');
      // act
      final result = nextBday.getDaysDifference(startDate, nextBday.targetDate);
      // assert
      expect(result, 265);
    });
  });

  group('targetDate is in the past', () {
    test('should return -9597 if from 1994-01-24', () async {
      // arrange
      final DateTime startDate = DateTime.parse('2020-05-04');
      final result = firstBday.getDaysDifference(
        startDate,
        firstBday.targetDate,
      );
      expect(result, -9597);
      // assert
    });
    test('should return -9597 if from 1994-01-24 18:04:00', () async {
      // arrange
      final DateTime startDate = DateTime.parse('2020-05-04 18:04:00');
      // act
      final result = firstBday.getDaysDifference(
        startDate,
        firstBday.targetDate,
      );
      // assert
      expect(result, -9597);
    });
  });
}
