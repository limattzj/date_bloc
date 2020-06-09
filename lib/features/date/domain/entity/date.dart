import 'package:equatable/equatable.dart';
import 'dart:math';

class Date extends Equatable {
  final String message;
  final DateTime targetDate;
  const Date({this.message, this.targetDate});

  /// return the number of days between [now] and [targetDate]
  int get daysDifference {
    return getDaysDifference(
      DateTime.now(),
      targetDate,
    );
  }

  /// return the number of days between x & y dates
  int getDaysDifference(DateTime x, DateTime y) {
    // tomorrow at 00:00
    return x.difference(y).inDays.abs();
  }

  @override
  List<Object> get props => [message, targetDate];
}

//  final nextDay = DateTime.utc(
//       x.year,
//       x.month,
//       x.day + 1,
//     );

//     // if targetDate is in the future, result += 1
//     return y.isBefore(DateTime.now())
//         ? y.difference(nextDay).inDays
//         : y.difference(nextDay).inDays + 1;
