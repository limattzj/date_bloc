import 'package:equatable/equatable.dart';

class Date extends Equatable {
  final String message;
  final DateTime targetDate;
  const Date({this.message, this.targetDate});

  /// Return numbers of days left from [tomorrow 00:00] to [targetDate 00:00].
  /// This getter cannot be test because it finds a difference between
  /// [targetDate] and [now], and [now] is always changing.
  int get daysDifference {
    return getDaysDifference(
      DateTime.now(),
      targetDate,
    );
  }

  int getDaysDifference(DateTime startDate, DateTime targetDate) {
    // tomorrow at 00:00
    final nextDay = DateTime.utc(
      startDate.year,
      startDate.month,
      startDate.day + 1,
    );

    // if targetDate is in the future, result += 1
    return targetDate.isBefore(DateTime.now())
        ? targetDate.difference(nextDay).inDays
        : targetDate.difference(nextDay).inDays + 1;
  }

  @override
  List<Object> get props => [message, targetDate];
}
