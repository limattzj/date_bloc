import 'package:date_bloc/features/date/domain/entity/date.dart';

abstract class DateRepository {
  /// get a List of Date objects from local data source
  List<Date> getDates();

  /// add a List of Date objects to local data source
  Future<bool> addDates(List<Date> dates);
}
