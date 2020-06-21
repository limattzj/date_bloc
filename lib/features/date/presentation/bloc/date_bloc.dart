import 'dart:async';
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

  // for debugging
  @override
  void onTransition(Transition<DateEvent, DateState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   super.onError(error, stackTrace);
  //   print('$error, $stackTrace');
  // }

  @override
  Stream<DateState> mapEventToState(DateEvent event) async* {
    // Add Date
    if (event is CreateDate) {
      List<Date> results = [];
      yield DateLoading();
      // verify input, to make sure AddDateEvent is not null
      if (event.date != null) {
        // get data that already stored in shared preference
        results += repo.getDates();

        // add a new entry to the data already in shared preferences
        results.add(Date(message: event.message, endDate: event.date));

        // add results to shared preferences
        final resultBool = await repo.addDates(results);

        if (resultBool) {
          yield DateLoaded(results);
          print('next line is return');
          return;
        } else {
          yield DateError(message: 'Failed to cache data');
        }
      } else {
        yield DateError(message: 'date cannot be null');
      }
    }
    // GetDates
    if (event is GetDates) {
      yield const DateLoading();
      final dates = repo.getDates();
      yield DateLoaded(dates);
    }
    // Delete Date
    if (event is DeleteDate) {
      yield DateLoading();
      List<Date> dates = repo.getDates();
      if (dates.isNotEmpty) {
        dates.removeAt(event.index);
      }
      yield await repo.addDates(dates)
          ? DateLoaded(dates)
          : DateError(message: 'Failed to cache data');
    }

    // Edit Date
    if (event is UpdateDate) {
      List<Date> results = [];
      yield DateLoading();
      results += repo.getDates();
      if (results.isNotEmpty) {
        Date newEntry = Date(message: event.message, endDate: event.date);
        // we update the old entry with new
        print(event.index);
        results[event.index] = newEntry;
        print(results);
      }

      yield await repo.addDates(results)
          ? DateLoaded(results)
          : DateError(message: 'Failed to cache data');
    }

    if (event is ClearDates) {
      List<Date> results = [];
      yield DateLoading();
      yield await repo.addDates(results)
          ? DateLoaded(results)
          : DateError(message: 'ClearDates: {"failed to cache dates"');
    }
  }
}
