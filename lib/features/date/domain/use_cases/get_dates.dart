import 'package:meta/meta.dart';
import 'package:date_bloc/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:date_bloc/core/use_case.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:date_bloc/features/date/repository/date_repository.dart';

class GetDates extends UseCase<List<Date>, NoParams> {
  final DateRepository repo;

  GetDates({@required this.repo});
  @override
  Either<Failure, List<Date>> call(NoParams p) {
    return repo.getDates();
  }
}
