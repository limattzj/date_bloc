import 'package:date_bloc/features/date/data/model/date_model.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DateModel model;
  setUp(() {
    final DateTime birthday = DateTime.tryParse('1994-01-24');
    model = DateModel(message: 'my first birthday', targetDate: birthday);
  });

  test('should be a subclass of Date', () async {
    // assert
    expect(model, isA<Date>());
  });

  test('should return corresponding json data', () async {
    // arrange
    final json = {
      "message": "my first birthday",
      "targetDate": "1994-01-24 00:00:00.000",
    };
    // act
    final result = model.toJson();
    // assert
    expect(result, json);
  });

  test('should return DateModel from json data', () async {
    // arrange
    final json = {
      "message": "my first birthday",
      "targetDate": "1994-01-24 00:00:00.000",
    };
    // act
    final result = DateModel.fromJson(json);
    // assert
    expect(result, model);
  });
}
