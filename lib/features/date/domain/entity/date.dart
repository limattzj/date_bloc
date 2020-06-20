import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Date extends Equatable {
  final String message;
  final DateTime endDate;
  const Date({@required this.message, @required this.endDate});

  /// return substring of [seconds] from findRemaining()
  int get secondsDifference {
    return int.parse(hoursLeft().toString().substring(6, 8));
  }

  /// return substring of [minutes] from findRemaining()
  int get minutesDifference {
    return int.parse(hoursLeft().toString().substring(3, 5));
  }

  /// return substring of [hours] from findRemaining()
  int get hoursDifference {
    return int.parse(hoursLeft().toString().substring(0, 2));
  }

  /// return the number of days between [now] and [endDate]
  int get daysDifference {
    return getDaysDifference(findNextDay(DateTime.now()), endDate);
  }

  /// return a Duration of HH:MM:SS of time that already has passed
  Duration hoursPassed({DateTime input}) {
    input ??= DateTime.now();
    return Duration(hours: 24) - hoursLeft(input: input);
  }

  /// return a Duration of HH:MM:SS remaining until the end of day
  Duration hoursLeft({DateTime input}) {
    // if input is null, then input is assigned to DateTime.now()
    input ??= DateTime.now();
    final nextDay = findNextDay(input);
    Duration remaining = nextDay.difference(input);
    return remaining;
  }

  /// return the number of days between x & y dates
  int getDaysDifference(DateTime x, DateTime y) {
    // what if the year is a leap year???
    var _result = (x.difference(y).inHours / 24).round().abs();
    return _result;
  }

  /// return a DateTime object that contains 00:00:00 of next day of the input
  DateTime findNextDay(DateTime input) {
    String year = input.year.toString();
    String month = input.month < 10 ? '0${input.month}' : '${input.month}';
    String day = input.day < 10 ? '0${input.day}' : '${input.day}';
    return DateTime.parse('$year-$month-$day').add(Duration(days: 1));
  }

  @override
  List<Object> get props => [message, endDate];

  @override
  String toString() {
    return 'Date: {$message, ${endDate.toString()}}';
  }
}
