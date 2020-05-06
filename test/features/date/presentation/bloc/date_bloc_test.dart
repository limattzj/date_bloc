import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:date_bloc/features/date/data/repository/date_repository_impl.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:date_bloc/features/date/domain/use_cases/add_dates.dart';
import 'package:date_bloc/features/date/domain/use_cases/get_dates.dart';
import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

class MockSharedPreference extends Mock implements SharedPreferences {}

void main() {
  DateBloc dateBloc;
  AddDates addDates;
  GetDates getDates;
  DateRepositoryImpl dateRepositoryImpl;
  DateLocalDataSourceImpl dateLocalDataSourceImpl;
  SharedPreferences sharedPreferences;

  group('event is GetDatesEvent', () {
    final upcomingBday = Date(
      message: 'upcoming birthday',
      targetDate: DateTime.parse('2021-01-24'),
    );
    final List<Date> dates = [upcomingBday];
    setUp(() async {
      SharedPreferences.setMockInitialValues(
        {
          "CACHED_DATES":
              "[{'message':'upcoming birthday','targetDate':'2021-01-24 00:00:00.000'}]"
        },
      );
      sharedPreferences = await SharedPreferences.getInstance();
      // local data source initialization
      dateLocalDataSourceImpl = DateLocalDataSourceImpl(sharedPreferences);

      // repo initialization
      dateRepositoryImpl = DateRepositoryImpl(dateLocalDataSourceImpl);

      // use case initialization
      addDates = AddDates(repo: dateRepositoryImpl);
      getDates = GetDates(repo: dateRepositoryImpl);
      // bloc initialization
      dateBloc = DateBloc(addDates: addDates, getDates: getDates);
    });

    blocTest(
      'should get ',
      build: () async => dateBloc,
      act: (bloc) async => dateBloc.add(const GetDatesEvent()),
      skip: 0,
      expect: [
        const DateInitial(),
        const DateLoading(),
        DateLoaded(dates),
      ],
    );
  });

  // group('event is AddDateEvent', () {
  //   blocTest(
  //     'should return DateInitial, DateLoading, DateLoaded',
  //     build: () async => dateBloc,
  //     act: (bloc) async => dateBloc.add(AddDateEvent(
  //       message: 'my birdthday',
  //       date: DateTime.parse('1994-01-24'),
  //     )),
  //     skip: 0,
  //     expect: [],
  //   );
  // });
}
