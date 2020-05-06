import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:date_bloc/features/date/data/model/date_model.dart';
import 'package:date_bloc/features/date/data/repository/date_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDateLocalDataSource extends Mock implements DateLocalDataSource {}

void main() {
  MockDateLocalDataSource mockDateLocalDataSource;
  DateRepositoryImpl dateRepositoryImpl;

  setUp(() {
    mockDateLocalDataSource = MockDateLocalDataSource();
    dateRepositoryImpl = DateRepositoryImpl(mockDateLocalDataSource);
  });

  test('getDates ', () async {
    // arrange
    final DateModel birthday = DateModel(
      message: 'upcoming birthday',
      targetDate: DateTime.parse('2021-01-24'),
    );

    final List<DateModel> dates = [birthday];
    when(mockDateLocalDataSource.getDatesFromCache())
        .thenAnswer((realInvocation) => dates);
    // act
    final result = dateRepositoryImpl.getDates();
    // assert
    expect(result, dates);
  });

  test('addDates ', () async {
    // arrange
    final DateModel birthday = DateModel(
      message: 'upcoming birthday',
      targetDate: DateTime.parse('2021-01-24'),
    );

    final List<DateModel> dates = [birthday];
    when(mockDateLocalDataSource.cacheDates(dates))
        .thenAnswer((realInvocation) => Future.value(true));
    // act
    final result = await dateRepositoryImpl.addDates(dates);
    // assert
    expect(result, true);
  });
}
