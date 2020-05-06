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
  final AddDates addDates;
  final GetDates getDates;

  DateBloc({@required this.addDates, @required this.getDates});

  @override
  DateState get initialState => const DateInitial();

  @override
  Stream<DateState> mapEventToState(DateEvent event) async* {
    if (event is AddDateEvent) {}
    if (event is GetDatesEvent) {
      yield const DateLoading();
      final dates = getDates();
      yield DateLoaded(dates);
    }
  }
}
