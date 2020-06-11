import 'package:date_bloc/features/date/data/model/date_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('should return a DateModel object', () async {
      // arrange
      final data = {'message': 'new year', 'endDate': '2020-01-01'};
      final expected = DateModel(
        message: 'new year',
        endDate: DateTime.parse('2020-01-01'),
      );
      // act
      final result = DateModel.fromJson(data);
      // assert
      expect(result, expected);
    });
  });

  group('toJson', () {
    test('should return a Map<String, dynamic>', () async {
      // arrange
      final object = DateModel(
        message: 'new year',
        endDate: DateTime.parse('2020-01-01'),
      );
      final data = {
        'message': 'new year',
        'endDate': '2020-01-01 00:00:00.000',
      };
      // act
      final result = object.toJson();
      // assert
      expect(result, data);
    });
  });
}
