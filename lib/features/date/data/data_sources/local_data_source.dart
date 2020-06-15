import 'dart:convert';
import 'package:date_bloc/features/date/data/model/date_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DateLocalDataSource {
  Future<bool> cacheDates(List<DateModel> dates);
  List<DateModel> getDatesFromCache();
}

class DateLocalDataSourceImpl implements DateLocalDataSource {
  final SharedPreferences sharedPreferences;

  DateLocalDataSourceImpl(this.sharedPreferences);

  // from List<DateModel> to String using sharedPreferences
  @override
  Future<bool> cacheDates(List<DateModel> dates) {
    final List<String> dataToCache = [];
    for (final date in dates) {
      dataToCache.add(jsonEncode(date.toJson()));
    }
    return sharedPreferences.setString('CACHED_DATES', dataToCache.toString());
  }

  // get String from sharedPreferences and convert to List<DateModel>
  @override
  List<DateModel> getDatesFromCache() {
    final List<DateModel> results = [];
    final cachedData = sharedPreferences.getString('CACHED_DATES');
    if (cachedData != null) {
      final jsonData = json.decode(cachedData) as List;
      for (final item in jsonData) {
        results.add(DateModel.fromJson(item as Map<String, dynamic>));
      }
    }
    return results;
  }
}
