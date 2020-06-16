import 'package:bloc_test/bloc_test.dart';
import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:date_bloc/features/date/data/repository/date_repository_impl.dart';
import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/test_data.dart';

void main() {
  DateBloc dateBloc;
  DateRepositoryImpl dateRepository;
  DateLocalDataSourceImpl dateLocalDataSource;
  SharedPreferences sharedPreferences;

  group('actual instance of dateBloc and its dependencies', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
      dateLocalDataSource = DateLocalDataSourceImpl(sharedPreferences);
      dateRepository = DateRepositoryImpl(localDataSource: dateLocalDataSource);
      dateBloc = DateBloc(repo: dateRepository);
    });

    group('CreateDates', () {
      test('should return DateInitial as a default state', () async {
        // assert
        expect(dateBloc.initialState, DateInitial());
      });

      blocTest(
        'should return [DateInitial, DateLoading, DateLoaded] when event is createEvent',
        build: () async {
          data03.toString();
          return dateBloc;
        },
        act: (bloc) {
          return bloc.add(
            CreateDate(message: 'new year', date: DateTime.parse('2021-01-01')),
          );
        },
        skip: 0,
        expect: [
          DateInitial(),
          DateLoading(),
          DateLoaded([data03]),
        ],
      );

      blocTest(
        'should return when createEvent is added 2x',
        build: () async {
          return dateBloc;
        },
        act: (bloc) {
          bloc.add(CreateDate(
              message: 'new year', date: DateTime.parse('2021-01-01')));
          return bloc.add(
            CreateDate(
                message: 'canada day', date: DateTime.parse('2020-07-01')),
          );
        },
        skip: 0,
        expect: [
          DateInitial(),
          DateLoading(),
          DateLoaded([data03]),
          DateLoading(),
          DateLoaded([data03, data02]),
        ],
      );

      test('should emits ', () async {
        // arrange
        dateBloc.add(CreateDate(
            message: 'new year', date: DateTime.parse('2021-01-01')));
        dateBloc.add(CreateDate(
            message: 'canada day', date: DateTime.parse('2020-07-01')));
        // act
        final expected = [
          DateInitial(),
          DateLoading(),
          DateLoaded([data03]),
          DateLoading(),
          DateLoaded([data03, data02]),
        ];
        // assert
        await emitsExactly(dateBloc, expected, skip: 0);
      });
    });

    group('GetDates, UpdateDate, DeleteDate', () {
      setUp(() async {
        final dates = [dataModel01, dataModel02];
        await dateLocalDataSource.cacheDates(dates);
      });

      test(
        'should emits Initial, Loading, Loaded when event is GetDates',
        () async {
          // arrange
          dateBloc.add(GetDates());
          // act
          final expected = [
            DateInitial(),
            DateLoading(),
            DateLoaded([data01, data02])
          ];
          // assert
          await emitsExactly(dateBloc, expected, skip: 0);
        },
      );

      test(
        'should emit DateLoaded(newDates) when event is UpdateDates',
        () async {
          // arrange
          dateBloc.add(GetDates());
          dateBloc.add(UpdateDate(
            index: 0,
            message: 'birthday',
            date: DateTime.parse('2020-01-24'),
          ));
          // act
          final expected = [
            DateInitial(),
            DateLoading(),
            DateLoaded([data01, data02]),
            DateLoading(),
            DateLoaded([data04, data02]),
          ];
          // assert
          await emitsExactly(dateBloc, expected, skip: 0);
        },
      );

      test(
        'should emit DateLoaded(lessDates) when event is UpdateDates',
        () async {
          // arrange
          dateBloc.add(GetDates());
          dateBloc.add(DeleteDate(index: 0));
          // act
          final expected = [
            DateInitial(),
            DateLoading(),
            DateLoaded([data01, data02]),
            DateLoading(),
            DateLoaded([data02]),
          ];
          // assert
          await emitsExactly(dateBloc, expected, skip: 0);
        },
      );

      test(
        'should emit DateLoaded(lessDates) when event is UpdateDates',
        () async {
          // arrange
          dateBloc.add(GetDates());
          dateBloc.add(DeleteDate(index: 0));
          dateBloc.add(DeleteDate(index: 0));
          // act
          final expected = [
            DateInitial(),
            DateLoading(),
            DateLoaded([data01, data02]),
            DateLoading(),
            DateLoaded([data02]),
            DateLoading(),
            DateLoaded([]),
          ];
          // assert
          await emitsExactly(dateBloc, expected, skip: 0);
        },
      );
    });
  });
}
