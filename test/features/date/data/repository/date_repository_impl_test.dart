import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:date_bloc/features/date/data/repository/date_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../core/test_data.dart';

class MockDateLocalDataSource extends Mock implements DateLocalDataSource {}

void main() {
  DateRepositoryImpl repo;
  MockDateLocalDataSource localDataSource;

  setUp(() {
    localDataSource = MockDateLocalDataSource();
    repo = DateRepositoryImpl(localDataSource: localDataSource);
  });

  group('addDates', () {
    test('should verify data is passed to localDataSource', () async {
      // arrange
      final dates = [data01, data02];
      final dateModels = [dataModel01, dataModel02];
      when(localDataSource.cacheDates(any)).thenAnswer((_) async => true);
      // act
      final result = await repo.addDates(dates);
      // assert
      expect(result, true);
      verify(localDataSource.cacheDates(dateModels));
    });
  });

  group('getDates', () {
    test('should return a List<Date> from localDataSource', () async {
      // arrange
      final dateModels = [dataModel01, dataModel02];
      when(localDataSource.getDatesFromCache()).thenAnswer((_) => dateModels);
      // act
      final result = repo.getDates();
      // assert
      expect(result.runtimeType, dateModels.runtimeType);
      expect(result, dateModels);
    });
  });
}
