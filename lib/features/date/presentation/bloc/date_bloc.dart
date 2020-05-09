import 'dart:async';
import 'dart:convert';
import 'package:date_bloc/features/date/domain/entity/date.dart';
import 'package:date_bloc/features/date/domain/repository/date_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  final DateRepository repo;

  DateBloc({@required this.repo});

  @override
  DateState get initialState => const DateInitial();

  @override
  void onTransition(Transition<DateEvent, DateState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<DateState> mapEventToState(DateEvent event) async* {
    if (event is AddDateEvent) {
      List<Date> results = [];
      yield const DateLoading();
      // verify input, to make sure AddDateEvent is not null
      if (event.date == null) {
        yield DateError(message: 'date cannot be null');
      } else {
        // get data that already stored in shared preference
        results += repo.getDates();

        // add a new entry to the data already in shared preferences
        results.add(Date(message: event.message, targetDate: event.date));

        // add results to shared preferences
        final resultBool = await repo.addDates(results);
        if (resultBool) {
          yield DateLoaded(results);
        } else {
          yield DateError(message: 'Failed to cache data');
        }
      }
    }
    if (event is GetDatesEvent) {
      yield const DateLoading();
      final dates = repo.getDates();
      yield DateLoaded(dates);
    }
    if (event is DeleteDateEvent) {
      yield DateLoading();
      List<Date> dates = repo.getDates();
      if (dates.isNotEmpty) {
        dates.removeAt(event.index);
      }
      final resultBool = await repo.addDates(dates);
      if (resultBool) {
        yield DateLoaded(dates);
      } else {
        yield DateError(message: 'Failed to cache data');
      }
    }
    if (event is EditDateEvent) {
      List<Date> results = [];
      yield DateLoading();
      List<Date> dates = repo.getDates();
      if (dates.isNotEmpty) {
        results += dates;
        // override Date tostring method
        // and check what is printed here
        Date newEntry = Date(message: event.message, targetDate: event.date);

        // what happended here
        results[event.index] = newEntry;
        print(results);
      }
      final resultBool = await repo.addDates(results);
      if (resultBool) {
        yield DateLoaded(results);
      } else {
        yield DateError(message: 'Failed to cache data');
      }
    }
  }
}
