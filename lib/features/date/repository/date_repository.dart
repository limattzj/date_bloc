import 'package:dartz/dartz.dart';
import 'package:date_bloc/core/failure.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';

abstract class DateRepository {
  /// get a List of Date objects from local data source
  Either<Failure, List<Date>> getDates();
}
