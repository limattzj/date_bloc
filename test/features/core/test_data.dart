import 'package:date_bloc/features/date/data/model/date_model.dart';
import 'package:date_bloc/features/date/domain/entity/date.dart';

final data01 = Date(
  message: 'new year',
  endDate: DateTime.parse('2020-01-01'),
);
final data02 = Date(
  message: 'canada day',
  endDate: DateTime.parse('2020-07-01'),
);

final data03 = Date(
  message: 'new year',
  endDate: DateTime.parse('2021-01-01'),
);
final data04 = Date(
  message: 'birthday',
  endDate: DateTime.parse('2020-01-24'),
);

final dataModel01 = DateModel(
  message: 'new year',
  endDate: DateTime.parse('2020-01-01'),
);

final dataModel02 = DateModel(
  message: 'canada day',
  endDate: DateTime.parse('2020-07-01'),
);

final tDates = [dataModel01, dataModel02];
final tResults =
    '''[{"message":"new year","endDate":"2020-01-01 00:00:00.000"}, {"message":"canada day","endDate":"2020-07-01 00:00:00.000"}]''';
