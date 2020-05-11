part of 'date_bloc.dart';

abstract class DateEvent extends Equatable {
  const DateEvent();
  @override
  List<Object> get props => [];
}

class GetDates extends DateEvent {
  const GetDates();
}

class CreateDate extends DateEvent {
  final String message;
  final DateTime date;

  const CreateDate({@required this.message, @required this.date});
  @override
  List<Object> get props => [message, date];
}

class UpdateDate extends DateEvent {
  final int index;
  final String message;
  final DateTime date;

  const UpdateDate({this.index, @required this.message, @required this.date});
  @override
  List<Object> get props => [message, date];
}

class DeleteDate extends DateEvent {
  final int index;

  const DeleteDate({@required this.index});

  @override
  List<Object> get props => [index];
}
