import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getDaysDifference', () {
    test('target is in the future', () async {
      // arrange
      final now = DateTime.parse('2020-06-20');
      final targetDate = DateTime.parse('2036-01-01');
      // act
      final result = Date.getDaysDifference(now, targetDate);
      // assert
      expect(result, 5673);
    });
    test('target is in the future', () async {
      // arrange
      final now = DateTime.parse('2020-06-20 00:00:01');
      final targetDate = DateTime.parse('2036-01-01');
      // act
      final result = Date.getDaysDifference(now, targetDate);
      // assert
      expect(result, 5672);
    });
    test('target is in the future', () async {
      // arrange
      final now = DateTime.parse('2020-06-20 12:00:00');
      final targetDate = DateTime.parse('2036-01-01');
      // act
      final result = Date.getDaysDifference(now, targetDate);
      // assert
      expect(result, 5672);
    });
  });
}
