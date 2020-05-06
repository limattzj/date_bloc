import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:date_bloc/features/date/data/model/date_model.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:date_bloc/features/date/domain/repository/date_repository.dart';

class DateRepositoryImpl implements DateRepository {
  final DateLocalDataSource localDataSource;

  DateRepositoryImpl(this.localDataSource);

  @override
  Future<bool> addDates(List<Date> dates) {
    final List<DateModel> results = [];
    for (final date in dates) {
      results.add(DateModel(
        message: date.message,
        targetDate: date.targetDate,
      ));
    }
    return localDataSource.cacheDates(results);
  }

  @override
  List<Date> getDates() {
    return localDataSource.getDatesFromCache();
  }
}