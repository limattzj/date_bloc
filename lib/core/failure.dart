import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object> get props => null;
}

class InvalidEntry extends Failure {
  final String message;

  InvalidEntry(this.message);

  @override
  List<Object> get props => [message];
}
