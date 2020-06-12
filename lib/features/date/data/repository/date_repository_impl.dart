import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:date_bloc/features/date/data/model/date_model.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:date_bloc/features/date/domain/repository/date_repository.dart';
import 'package:meta/meta.dart';

class DateRepositoryImpl implements DateRepository {
  final DateLocalDataSource localDataSource;

  DateRepositoryImpl({@required this.localDataSource});

  @override
  Future<bool> addDates(List<Date> dates) {
    // it loops through dates and transform items to type DateModel
    final List<DateModel> results = [];
    for (final date in dates) {
      results.add(
        DateModel(
          message: date.message,
          endDate: date.endDate,
        ),
      );
    }
    return localDataSource.cacheDates(results);
  }

  @override
  List<Date> getDates() {
    final result = localDataSource.getDatesFromCache();
    print('result is of Type ${result.runtimeType} ');
    return result;
  }
}
