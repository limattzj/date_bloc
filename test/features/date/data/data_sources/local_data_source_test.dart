import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/test_data.dart';

void main() {
  DateLocalDataSourceImpl dateLocalDataSourceImpl;
  SharedPreferences sharedPreferences;
  group('cacheDates', () {
    test('should cache data using sharedPreferences', () async {
      // arrange
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
      dateLocalDataSourceImpl = DateLocalDataSourceImpl(sharedPreferences);
      // act
      final result = await dateLocalDataSourceImpl.cacheDates(tDates);
      // assert
      expect(result, true);
      expect(sharedPreferences.getString('CACHED_DATES'), tResults);
    });
  });

  group('getDatesFromCache', () {
    test('should get data from shared preference and return a List<DateModel>',
        () async {
      // arrange
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
      dateLocalDataSourceImpl = DateLocalDataSourceImpl(sharedPreferences);
      await dateLocalDataSourceImpl.cacheDates(tDates);
      // act
      final result = await dateLocalDataSourceImpl.getDatesFromCache();
      // assert
      expect(result, tDates);
    });
  });
}
