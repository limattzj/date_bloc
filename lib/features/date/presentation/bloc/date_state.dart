part of 'date_bloc.dart';

abstract class DateState extends Equatable {
  const DateState();
}

class DateInitial extends DateState {
  const DateInitial();
  @override
  List<Date> get props => [];
}

class DateLoading extends DateState {
  const DateLoading();
  @override
  List<Date> get props => [];
}

class DateLoaded extends DateState {
  final List<Date> dates;

  DateLoaded(this.dates);

  @override
  String toString() {
    return 'DateLoaded: {$dates}';
  }

  // @override
  // List<Object> get props => dates;
  @override
  List<Object> get props {
    final List<Map> results = [];
    for (var item in dates) {
      final Map<String, dynamic> entry = {
        "message": item.message,
        "endDate": item.endDate,
      };
      results.add(entry);
    }
    return results;
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
