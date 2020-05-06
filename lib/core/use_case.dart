import 'package:dartz/dartz.dart';
import 'package:date_bloc/core/failure.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params p);
}

class Params extends Equatable {
  @override
  List<Object> get props => null;
}

class NoParams extends Equatable {
  @override
  List<Object> get props => null;
}
