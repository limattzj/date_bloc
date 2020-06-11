import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:meta/meta.dart';

class DateModel extends Date {
  const DateModel({
    @required String message,
    @required DateTime endDate,
  }) : super(message: message, endDate: endDate);

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      message: json['message'] as String,
      endDate: DateTime.parse(json['endDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "endDate": endDate.toString(),
    };
  }
}
