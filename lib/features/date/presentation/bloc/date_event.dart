part of 'date_bloc.dart';

abstract class DateEvent extends Equatable {
  const DateEvent();
  @override
  List<Object> get props => [];
}

class GetDatesEvent extends DateEvent {
  const GetDatesEvent();
}

class AddDateEvent extends DateEvent {
  final String message;
  final DateTime date;

  const AddDateEvent({@required this.message, @required this.date});
  @override
  List<Object> get props => [message, date];
}

class EditDateEvent extends DateEvent {
  final int index;
  final String message;
  final DateTime date;

  const EditDateEvent(
      {this.index, @required this.message, @required this.date});
  @override
  List<Object> get props => [message, date];
}

class DeleteDateEvent extends DateEvent {
  final int index;

  const DeleteDateEvent({@required this.index});

  @override
  List<Object> get props => [index];
}
