part of 'date_bloc.dart';

abstract class DateState extends Equatable {
  const DateState();
}

class DateInitial extends DateState {
  const DateInitial();
  @override
  List<Object> get props => [];
}

class DateLoading extends DateState {
  const DateLoading();
  @override
  List<Object> get props => [];
}

class DateLoaded extends DateState {
  final List<Date> dates;

  DateLoaded(this.dates);

  @override
  String toString() {
    return 'DateLoaded: {$dates}';
  }

  @override
  List<Object> get props => [dates];
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
