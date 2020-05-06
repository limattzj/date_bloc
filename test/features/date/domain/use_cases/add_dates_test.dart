import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:date_bloc/features/date/domain/use_cases/add_dates.dart';
import 'package:date_bloc/features/date/repository/date_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDateRepository extends Mock implements DateRepository {}

void main() {
  MockDateRepository mockDateRepository;
  AddDates addDates;

  setUp(() {
    mockDateRepository = MockDateRepository();
    addDates = AddDates(repo: mockDateRepository);
  });

  test('should return true if successfully added to local data source',
      () async {
    // arrange
    List<Date> dates;
    when(mockDateRepository.addDates(dates))
        .thenAnswer((realInvocation) async => true);
    // act
    final result = await addDates(dates);
    // assert
    expect(result, true);
  });
}
