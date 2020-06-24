import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Date date;
  group('findNextDay', () {
    test('should return a DateTime has the value 00:00 of next day', () async {
      // arrange
      final DateTime input = DateTime.parse('2020-01-01 12:00:00');
      // act
      final result = Date.findNextDay(input);
      // assert
      expect(result, DateTime.parse('2020-01-02 00:00:00'));
    });
    test('should return a DateTime has the value 00:00 of next day', () async {
      // arrange
      final DateTime input = DateTime.parse('2020-01-01 23:59:59');
      // act
      final result = Date.findNextDay(input);
      // assert
      expect(result, DateTime.parse('2020-01-02 00:00:00'));
    });
  });

  group('findToday', () {
    test('should return 00:00:000 when given a DateTime obj', () async {
      // arrange
      final DateTime input = DateTime.parse('20200101 12:30:00');
      // act
      final result = Date.findToday(input);
      // assert
      expect(result, DateTime.parse('20200101'));
    });
    test('should return a DateTime has the value 00:00 of next day', () async {
      // arrange
      final DateTime input = DateTime.parse('2020-01-01 23:59:59');
      // act
      final result = Date.findToday(input);
      // assert
      expect(result, DateTime.parse('2020-01-01 00:00:00'));
    });
  });

  group('getDaysDifference', () {
    test('leap year: should return the difference between two days', () async {
      // arrange
      final DateTime startDate = DateTime.parse('2020-01-01');
      final DateTime endDate = DateTime.parse('2020-06-10');
      final date = Date(message: 'hello', endDate: endDate);

      // act
      final result = Date.getDaysDifference(startDate, date.endDate);
      // assert
      expect(result, 161);
    });

    test('non-leap year: should return the difference between two days',
        () async {
      // arrange
      final DateTime startDate = DateTime.parse('2019-01-01');
      final DateTime endDate = DateTime.parse('2019-06-10');
      // act
      final result = Date.getDaysDifference(startDate, endDate);
      // assert
      expect(result, 160);
    });
    test('leap year: should return the difference between two days', () async {
      // arrange
      final DateTime startDate = DateTime.parse('2000-01-01');
      final DateTime endDate = DateTime.parse('2000-12-10');
      // act
      final result = Date.getDaysDifference(startDate, endDate);
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
      final result = date.hoursLeft(startDate: input);
      // act
      // assert
      expect(result, expected);
    });

    test('should return how many hours left in different format', () async {
      // arrange
      final input = DateTime.parse('2020-01-01 18:01:00');
      final expected = Duration(hours: 5, minutes: 59, seconds: 00);
      final result = date.hoursLeft(startDate: input);
      debugPrint('$result');
      var _hours = result.inHours;
      var _minutes = result.inMinutes - result.inHours * 60;
      var _seconds = result.inSeconds - _hours * 60 * 60 - _minutes * 60;
      debugPrint(' Hours ${_hours}');
      debugPrint(' Minutes ${_minutes}');
      debugPrint(' Seconds ${_seconds}');

      // act
      // assert
      expect(result, expected);
    });

    test('should return HoursLeft as a Duration', () async {
      // arrange
      final result = date.hoursLeft();
      // act

      // assert
      expect(result, isA<Duration>());
    });

    test('should return how many hours left of today', () async {
      // act
      final hour = date.hoursDifference;
      final minutes = date.minutesDifference;
      final seconds = date.secondsDifference;
      // assert
      debugPrint('$hour : $minutes : $seconds');
    });

    test('should return 184 days 9 hours 40 mins between two days', () async {
      // arrange
      final startDate = DateTime.parse('2020-06-23 14:20:00');
      final endDate = DateTime.parse('2020-12-25');
      date = Date(message: 'Christmas', endDate: endDate);

      // act
      final days = Date.getDaysDifference(startDate, date.endDate);
      final hours = date.hoursLeft(startDate: startDate);
      // assert
      expect(days, 184);
      debugPrint('${hours}');
      expect(hours, Duration(hours: 9, minutes: 40));
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
      final expectedDaysDifference = 2;
      // act
      final result = date.hoursPassed(input: input);
      final daysDifference = Date.getDaysDifference(date.endDate, input);
      // assert
      expect(result, expected);
      expect(daysDifference, expectedDaysDifference);
    });

    test('should return how many hours already passed', () async {
      // arrange
      final input = DateTime.parse('2020-01-03 21:34:00');
      final expected = Duration(hours: 21, minutes: 34, seconds: 0);
      // act
      final result = date.hoursPassed(input: input);
      // assert
      expect(result, expected);
    });
    test('should return how many hours already passed', () async {
      // act
      final result = date.hoursPassed();
      // assert
      debugPrint(result.toString());
      debugPrint(date.hoursPassed().toString());
    });

    test('should return 151 days 14 hours 20min', () async {
      // arrange
      final startDate = DateTime.parse('2020-06-23 14:20:00');
      final endDate = DateTime.parse('2020-01-24');
      final date = Date(message: 'bday', endDate: endDate);
      // act
      final days = Date.getDaysDifference(endDate, startDate);
      debugPrint('$days');
      final hours = date.hoursPassed(input: startDate);
      // assert

      expect(days, 151);
      expect(hours, Duration(hours: 14, minutes: 20));
    });
  });
}
