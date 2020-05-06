import 'package:date_bloc/core/usecase.dart';
import 'package:date_bloc/features/date/domain/repository/date_repository.dart';
import 'package:meta/meta.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';

/// get List<Date> from repository.
class GetDates extends UseCase {
  final DateRepository repo;

  GetDates({@required this.repo});

  List<Date> call() {
    return repo.getDates();
  }
}
