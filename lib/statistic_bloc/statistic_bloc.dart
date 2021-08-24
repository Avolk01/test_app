import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:register_page/models/firebase_controller.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc(this._controller, this._uid) : super(StatisticInitial()) {
    add(GetDates());
  }

  String _uid;
  FirebaseController _controller;

  @override
  Stream<StatisticState> mapEventToState(
    StatisticEvent event,
  ) async* {
    if (event.key == 'dates')
      yield Dates(await _controller.getListOfDates(_uid));
    if (event.key == 'values') {
      yield Values(await _controller.getValues(_uid, event.date));
    }
  }
}
