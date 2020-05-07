import 'dart:async';
import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:date_bloc/features/date/domain/use_cases/add_dates.dart';
import 'package:date_bloc/features/date/domain/use_cases/get_dates.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  List<Date> results = [];
  final AddDates addDates;
  final GetDates getDates;

  DateBloc({@required this.addDates, @required this.getDates});

  @override
  DateState get initialState => const DateInitial();

  @override
  Stream<DateState> mapEventToState(DateEvent event) async* {
    if (event is AddDateEvent) {
      yield const DateLoading();

      // get data that already stored in shared preference
      final List<Date> dates = getDates();
      // print(dates.runtimeType);
      results += dates;

      // add a new entry to the data already in shared preferences
      results.add(Date(
        message: event.message,
        targetDate: event.date,
      ));

      // add results to shared preferences
      final resultBool = await addDates(results);
      if (resultBool) {
        yield DateLoaded(results);
      }
    }
    if (event is GetDatesEvent) {
      yield const DateLoading();
      final dates = getDates();
      yield DateLoaded(dates);
    }
  }
}
