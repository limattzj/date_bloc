import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:meta/meta.dart';

class DateModel extends Date {
  final String message;
  final DateTime targetDate;

  DateModel({
    @required this.message,
    @required this.targetDate,
  }) : super(message: message, targetDate: targetDate);

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      message: json['message'] as String,
      targetDate: DateTime.parse(json['targetDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "targetDate": targetDate.toString(),
    };
  }
}
