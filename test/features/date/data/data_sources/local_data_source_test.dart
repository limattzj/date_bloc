import 'dart:convert';

import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:date_bloc/features/date/data/model/date_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  DateLocalDataSourceImpl dateLocalDataSourceImpl;
  SharedPreferences sharedPreferences;

  test('should cache the data', () async {
    // arrange
    final DateModel birthday = DateModel(
      message: 'upcoming birthday',
      targetDate: DateTime.parse('2021-01-24'),
    );

    final List<DateModel> dates = [birthday];

    final json = {
      "message": "upcoming birthday",
      "targetDate": "2021-01-24 00:00:00.000",
    };
    final jsonString = jsonEncode(json);
    final dataGetFromCache = [jsonString].toString();
    // print(dataGetFromCache);
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    dateLocalDataSourceImpl = DateLocalDataSourceImpl(sharedPreferences);
    // act
    final result = await dateLocalDataSourceImpl.cacheDates(dates);
    // assert
    expect(result, true);
    expect(sharedPreferences.getString('CACHED_DATES'), dataGetFromCache);
  });

  test('should getDatesFromCache', () async {
    final DateModel birthday = DateModel(
      message: 'upcoming birthday',
      targetDate: DateTime.parse('2021-01-24'),
    );

    final List<DateModel> dates = [birthday];
    // arrange
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    dateLocalDataSourceImpl = DateLocalDataSourceImpl(sharedPreferences);
    await dateLocalDataSourceImpl.cacheDates(dates);
    // act
    final result = dateLocalDataSourceImpl.getDatesFromCache();
    // assert
    expect(result, dates);
  });

  test('should cacheDates with long list of data', () async {
    // arrange
    final DateModel birthday = DateModel(
      message: 'upcoming birthday',
      targetDate: DateTime.parse('2021-01-24'),
    );
    final DateModel comingHome = DateModel(
      message: 'coming home',
      targetDate: DateTime.parse('2020-11-15'),
    );
    final DateModel goingAway = DateModel(
      message: 'going away again',
      targetDate: DateTime.parse('2021-01-10'),
    );
    final List<DateModel> data = [birthday, comingHome, goingAway];

    const returnedDate =
        '[{"message":"upcoming birthday","targetDate":"2021-01-24 00:00:00.000"}, {"message":"coming home","targetDate":"2020-11-15 00:00:00.000"}, {"message":"going away again","targetDate":"2021-01-10 00:00:00.000"}]';
    // act
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    dateLocalDataSourceImpl = DateLocalDataSourceImpl(sharedPreferences);
    final result = await dateLocalDataSourceImpl.cacheDates(data);
    // assert
    expect(sharedPreferences.getString('CACHED_DATES'), returnedDate);
    expect(result, true);
  });
}
