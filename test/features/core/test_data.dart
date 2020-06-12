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

final dataModel01 = DateModel(
  message: 'new year',
  endDate: DateTime.parse('2020-01-01'),
);

final dataModel02 = DateModel(
  message: 'canada day',
  endDate: DateTime.parse('2020-07-01'),
);
