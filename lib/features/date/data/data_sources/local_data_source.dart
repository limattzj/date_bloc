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
  @override
  Future<bool> cacheDates(List<DateModel> dates) {
    final List<String> dataToCache = [];
    for (final date in dates) {
      dataToCache.add(jsonEncode(date.toJson()));
    }
    return sharedPreferences.setString('CACHED_DATES', dataToCache.toString());
  }

  @override
  List<DateModel> getDatesFromCache() {
    final result = sharedPreferences.getString('CACHED_DATES');
    final jsonData = jsonDecode(result) as List;
    print(result);
    final List<DateModel> results = [];
    for (final item in jsonData) {
      results.add(DateModel.fromJson(item as Map<String, dynamic>));
    }
    return results;
  }
}
