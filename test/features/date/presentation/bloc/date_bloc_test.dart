import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:date_bloc/features/date/data/model/date_model.dart';
import 'package:date_bloc/features/date/data/repository/date_repository_impl.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:date_bloc/features/date/domain/use_cases/add_dates.dart';
import 'package:date_bloc/features/date/domain/use_cases/get_dates.dart';
import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  DateBloc dateBloc;
  AddDates addDates;
  GetDates getDates;
  DateRepositoryImpl dateRepositoryImpl;
  DateLocalDataSourceImpl dateLocalDataSource;
  SharedPreferences sharedPreferences;

  final List<Date> resultDate = [
    Date(
      message: 'upcoming birthday',
      targetDate: DateTime.parse('2021-01-24'),
    )
  ];

  group('GetDatesEvent', () {
    setUp(() async {
      // shared preference
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
      // local data source
      dateLocalDataSource = DateLocalDataSourceImpl(sharedPreferences);
      // repo
      dateRepositoryImpl = DateRepositoryImpl(dateLocalDataSource);
      // use case
      addDates = AddDates(repo: dateRepositoryImpl);
      getDates = GetDates(repo: dateRepositoryImpl);
      // bloc
      dateBloc = DateBloc(addDates: addDates, getDates: getDates);
    });

    test('initialState should be DateInitial', () async {
      // assert
      expect(dateBloc.initialState, const DateInitial());
    });

    blocTest(
      'should get a List of Date when add GetDatesEvent',
      build: () async {
        // cache the data using local data source
        final DateModel birthday = DateModel(
          message: 'upcoming birthday',
          targetDate: DateTime.parse('2021-01-24'),
        );
        final listToCache = [birthday];
        dateLocalDataSource.cacheDates(listToCache);
        return dateBloc;
      },
      act: (bloc) async {
        return dateBloc.add(const GetDatesEvent());
      },
      skip: 0,
      expect: [
        const DateInitial(),
        const DateLoading(),
        DateLoaded(resultDate),
      ],
    );
  });

  group('AddDateEvent', () {
    setUp(() async {
      // shared preference
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
      // local data source
      dateLocalDataSource = DateLocalDataSourceImpl(sharedPreferences);
      // repo
      dateRepositoryImpl = DateRepositoryImpl(dateLocalDataSource);
      // use case
      addDates = AddDates(repo: dateRepositoryImpl);
      getDates = GetDates(repo: dateRepositoryImpl);
      // bloc
      dateBloc = DateBloc(addDates: addDates, getDates: getDates);
    });

    final firstBday = Date(
      message: 'my first birthday',
      targetDate: DateTime.parse('1994-01-24'),
    );
    final result = [firstBday];

    blocTest(
      'should add A list of items to SharedPreference when event is AddDateEvent',
      build: () async {
        return dateBloc;
      },
      act: (bloc) async {
        dateBloc.add(AddDateEvent(
          message: 'my first birthday',
          date: DateTime.parse('1994-01-24'),
        ));
      },
      skip: 0,
      expect: [
        const DateInitial(),
        const DateLoading(),
        DateLoaded(result),
      ],
    );
  });
}
