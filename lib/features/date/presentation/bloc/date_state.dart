part of 'date_bloc.dart';

abstract class DateState extends Equatable {
  const DateState();
  @override
  List<Object> get props => [];
}

class DateInitial extends DateState {
  const DateInitial();
}

class DateLoading extends DateState {
  const DateLoading();
}

class DateLoaded extends DateState {
  final List<Date> dates;

  const DateLoaded(this.dates);

  @override
  List<Object> get props {
    final results = [];
    for (final item in dates) {
      final Map<String, dynamic> keyValuePair = {
        "message": item.message,
        "targetDate": item.targetDate.toString(),
      };

      results.add(keyValuePair);
    }
    return results;
  }

  @override
  String toString() {
    final List<String> results = [];
    for (final item in dates) {
      final Map<String, dynamic> keyValuePair = {
        "message": item.message,
        "targetDate": item.targetDate.toString(),
      };

      results.add(jsonEncode(keyValuePair));
    }
    return results.toString();
  }
}

class DateError extends DateState {
  final String message;

  const DateError({this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'DateError: {$message}';
  }
}
