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
  List<Object> get props => [dates];
}
