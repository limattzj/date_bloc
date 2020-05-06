import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:meta/meta.dart';

class DateModel extends Date {
  const DateModel({
    @required String message,
    @required DateTime targetDate,
  }) : super(message: message, targetDate: targetDate);

  factory DateModel.fromJson(Map<String, String> json) {
    return DateModel(
      message: json['message'],
      targetDate: DateTime.parse(json['targetDate']),
    );
  }

  Map<String, String> toJson() {
    return {
      "message": message,
      "targetDate": targetDate.toString(),
    };
  }
}
