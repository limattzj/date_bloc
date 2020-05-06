import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:date_bloc/features/date/domain/repository/date_repository.dart';
import 'package:date_bloc/features/date/domain/use_cases/get_dates.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDateRepository extends Mock implements DateRepository {}

void main() {
  MockDateRepository mockDateRepository;
  GetDates getDates;

  setUp(() {
    mockDateRepository = MockDateRepository();
    getDates = GetDates(repo: mockDateRepository);
  });

  test('should return a List of Date when call usecase', () async {
    // arrange
    final List<Date> dates = [];
    when(mockDateRepository.getDates()).thenAnswer((realInvocation) => dates);
    // act
    final result = getDates();
    // assert
    expect(result, dates);
  });
}
