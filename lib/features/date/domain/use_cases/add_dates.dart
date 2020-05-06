import 'package:date_bloc/core/usecase.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:meta/meta.dart';
import 'package:date_bloc/features/date/repository/date_repository.dart';

/// add List<Date> [dates] to repository, return true if success.
class AddDates extends UseCase {
  final DateRepository repo;

  AddDates({@required this.repo});

  Future<bool> call(List<Date> dates) {
    return repo.addDates(dates);
  }
}
