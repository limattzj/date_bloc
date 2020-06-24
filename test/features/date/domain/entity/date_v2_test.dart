import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getDaysDifference', () {
    group('target is in future', () {
      test('2020-06-20', () async {
        // arrange
        final now = DateTime.parse('2020-06-20');
        final targetDate = DateTime.parse('2036-01-01');
        // act
        final result = Date.getDaysDifference(now, targetDate);
        // assert
        expect(result, 5673);
      });
      test('2020-06-20 00:00:01', () async {
        // arrange
        final now = DateTime.parse('2020-06-20 00:00:01');
        final targetDate = DateTime.parse('2036-01-01');
        // act
        final result = Date.getDaysDifference(now, targetDate);
        // assert
        expect(result, 5672);
      });
      test('2020-06-20 12:00:00', () async {
        // arrange
        final now = DateTime.parse('2020-06-20 12:00:00');
        final targetDate = DateTime.parse('2036-01-01');
        // act
        final result = Date.getDaysDifference(now, targetDate);
        // assert
        expect(result, 5672);
      });
      test('2020-06-20 23:59:00', () async {
        // arrange
        final now = DateTime.parse('2020-06-20 23:59:00');
        final targetDate = DateTime.parse('2036-01-01');
        // act
        final result = Date.getDaysDifference(now, targetDate);
        // assert
        expect(result, 5672);
      });
    });

    group('target is in the past', () {
      test('2020-06-24', () async {
        // arrange
        final now = DateTime.parse('2020-06-24');
        final targetDate = DateTime.parse('2000-01-01');
        // act
        final result = Date.getDaysDifference(now, targetDate);
        // assert
        expect(result, 7480);
      });

      test('2020-06-24', () async {
        // arrange
        final now = DateTime.parse('2020-06-24 10:29:00');
        final targetDate = DateTime.parse('2000-01-01');
        // act
        final result = Date.getDaysDifference(now, targetDate);
        // assert
        expect(result, 7480);
      });
      test('2020-06-24', () async {
        // arrange
        final now = DateTime.parse('2020-06-24 23:59:00');
        final targetDate = DateTime.parse('2000-01-01');
        // act
        final result = Date.getDaysDifference(now, targetDate);
        // assert
        expect(result, 7480);
      });
    });
  });
}
