import 'package:date_bloc/core/failure.dart';

String getMonth(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'Aug';
    case 9:
      return 'Sept';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      throw InvalidEntry('Invalid input of month');
  }
}

String parseDate(int input) {
  // add fail/safe for input <= 0
  if (input < 10) {
    return '0$input';
  } else {
    return '$input';
  }
}
