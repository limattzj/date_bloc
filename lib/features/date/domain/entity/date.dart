import 'package:date_bloc/core/process_date.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Date extends Equatable {
  final String message;
  final DateTime endDate;

  const Date({@required this.message, @required this.endDate});

  bool get isAfter {
    return DateTime.now().isAfter(endDate);
  }

  /// return substring of [seconds] from findRemaining()
  int get secondsDifference {
    var _secondsLeft = (hoursLeft().inSeconds) -
        (hoursDifference * 3600).abs() -
        (minutesDifference * 60).abs() +
        1;
    var _secondsPassed = (hoursPassed().inSeconds) -
        (hoursDifference * 3600).abs() -
        (minutesDifference * 60).abs();
    ;
    return isAfter ? _secondsPassed : _secondsLeft;
  }

  /// return substring of [minutes] from findRemaining()
  int get minutesDifference {
    var _minutesLeft = hoursLeft().inMinutes - hoursDifference * 60;
    var _minutesPassed = hoursPassed().inMinutes - hoursDifference * 60;
    var _result = isAfter ? _minutesPassed : _minutesLeft;

    return _result;
  }

  /// return substring of [hours] from findRemaining()
  int get hoursDifference {
    var _result = isAfter ? hoursPassed().inHours : hoursLeft().inHours;
    return _result;
  }

  /// return the number of days between [now] and [endDate]
  int daysDifference() {
    return getDaysDifference(DateTime.now(), endDate);
  }

  /// return a Duration of HH:MM:SS of time that already has passed
  Duration hoursPassed({DateTime input}) {
    input ??= DateTime.now();
    return Duration(hours: 24) - hoursLeft(startDate: input);
  }

  /// return a Duration of HH:MM:SS remaining until the end of day
  Duration hoursLeft({DateTime startDate}) {
    // if input is null, then input is assigned to DateTime.now()
    startDate ??= DateTime.now();
    final nextDay = findNextDay(startDate);
    Duration remaining = nextDay.difference(startDate);
    return remaining;
  }

  /// return the number of days between x & y dates
  static int getDaysDifference(DateTime now, DateTime targetDate) {
    // process the input so that only consider the year-month-day for
    // both x and y
    int _result;
    DateTime _now;
    if (targetDate.isAfter(now)) {
      if (now.hour > 0 || now.minute > 0 || now.second > 0) {
        _now = findNextDay(now);
      } else {
        _now = findToday(now);
      }
      DateTime _y = findToday(targetDate);
      _result = (_now.difference(_y).inHours / 24).round().abs();
    } else {
      DateTime _now = findToday(now);
      DateTime _y = findToday(targetDate);
      _result = (_now.difference(_y).inHours / 24).round().abs();
    }

    // debugPrint('result: $_result');
    return _result;
  }

  /// return a DateTime object that contains 00:00:00 of next day of the input
  static DateTime findNextDay(DateTime input) {
    DateTime _input = findToday(input);
    return _input.add(Duration(days: 1));
  }

  /// return yyyy-mm-dd 00:00:000 of given DateTime of the input
  static DateTime findToday(DateTime input) {
    String _year = input.year.toString();
    String _month = parseDate(input.month);
    String _day = parseDate(input.day);
    DateTime _result = DateTime.parse('$_year$_month$_day');

    return _result;
  }

  @override
  List<Object> get props => [message, endDate];

  @override
  String toString() {
    return 'Date: {$message, ${endDate.toString()}}';
  }
}
