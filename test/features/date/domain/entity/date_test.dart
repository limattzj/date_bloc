import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Date date;
  group('findNextDay', () {
    setUp(() {
      date = Date(
        message: 'hello world',
        endDate: DateTime.parse('2020-01-01'),
      );
    });
    test('should return a DateTime has the value 00:00 of next day', () async {
      // arrange
      final DateTime input = DateTime.parse('2020-01-01 12:00:00');
      // act
      final result = date.findNextDay(input);
      debugPrint(result.toString());
      // assert
      expect(result, DateTime.parse('2020-01-02 00:00:00'));
    });
    test('should return a DateTime has the value 00:00 of next day', () async {
      // arrange
      final DateTime input = DateTime.parse('2020-01-01 23:59:59');
      // act
      final result = date.findNextDay(input);
      debugPrint(result.toString());
      // assert
      expect(result, DateTime.parse('2020-01-02 00:00:00'));
    });
  });

  group('getDaysDifference', () {
    test('leap year: should return the difference between two days', () async {
      // arrange
      final DateTime startDate = DateTime.parse('2020-01-01');
      final DateTime endDate = DateTime.parse('2020-06-10');
      final date = Date(message: 'hello', endDate: endDate);

      // act
      final result = date.getDaysDifference(startDate, date.endDate);
      // assert
      expect(result, 161);
    });

    test('non-leap year: should return the difference between two days',
        () async {
      // arrange
      final DateTime startDate = DateTime.parse('2019-01-01');
      final DateTime endDate = DateTime.parse('2019-06-10');
      final date = Date(message: 'hello', endDate: endDate);
      // act
      final result = date.getDaysDifference(startDate, endDate);
      // assert
      expect(result, 160);
    });
    test('leap year: should return the difference between two days', () async {
      // arrange
      final DateTime startDate = DateTime.parse('2000-01-01');
      final DateTime endDate = DateTime.parse('2000-12-10');
      final date = Date(message: 'hello', endDate: endDate);
      // act
      final result = date.getDaysDifference(startDate, endDate);
      // assert
      expect(result, 344);
    });
  });

  group('hoursLeft', () {
    setUp(() {
      date = Date(message: 'hello', endDate: DateTime.parse('2020-01-01'));
    });
    test('should return how many hours left', () async {
      // arrange
      final input = DateTime.parse('2020-01-01 12:00:00');
      final expected = Duration(hours: 12);
      final result = date.hoursLeft(input: input);
      // act
      // assert
      expect(result, expected);
    });

    test('should return how many hours left of today', () async {
      // act
      final result = date.hoursLeft();
      // assert
      debugPrint(result.toString());
    });
  });

  group('hoursPassed', () {
    setUp(() {
      date = Date(message: 'hello', endDate: DateTime.parse('2020-01-01'));
    });
    test('should return how many hours already passed', () async {
      // arrange
      final input = DateTime.parse('2020-01-03 13:00:00');
      final expected = Duration(hours: 13);
      // act
      final result = date.hoursPassed(input: input);
      // assert
      expect(result, expected);
    });

    test('should return how many hours already passed', () async {
      // arrange
      final input = DateTime.parse('2020-01-03 21:34:00');
      final expected = Duration(hours: 21, minutes: 34);
      // act
      final result = date.hoursPassed(input: input);
      // assert
      expect(result, expected);
    });
    test('should return how many hours left of today', () async {
      // act
      final result = date.hoursPassed();
      // assert
      debugPrint(result.toString());
    });
  });
}
