import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:register_page/assets/strings.dart';
import 'package:register_page/models/firebase_controller.dart';
import 'package:register_page/models/shared_pref_controller.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc(
    this._controller,
    this._sharedController,
    this._uid,
    this._date,
  ) : super(CounterInitial()) {
    add(Loading());
  }

  SharedPrefController _sharedController;
  FirebaseController _controller;
  String _date;
  String _uid;

  List<int> _databaseValues = [0, 0, 0, 0];
  List<int> _counterValues = [0, 0, 0, 0];

  void _incCounter(int index) {
    switch (index) {
      case 1:
        _counterValues[0]++;
        break;
      case 2:
        _counterValues[1]++;
        break;
      case 3:
        _counterValues[2]++;
        break;
      case 4:
        _counterValues[3]++;
        break;
    }
  }

  List<int> _twoListSum(List<int> l1, List<int> l2) {
    List<int> result = [];
    for (int i = 0; i < l1.length; i++) {
      result.add(l1[i] + l2[i]);
    }
    return result;
  }

  Future<void> loadData() async {

  }

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is Loading) {

      yield LoadingState();


      _databaseValues = await _controller.initFieldsFromDatabase(_uid, _date);

      yield GraphData(
        _databaseValues,
        await _controller.getClicks(
            _uid, await _controller.getListOfDates(_uid)),
        await _controller.getListOfDateTime(_uid),
      );
    } else {
      if (event is IncCount) _incCounter(event.index);
      List<int> counterList = _twoListSum(_databaseValues, _counterValues);
      _controller.updateDatabase(_uid, _date, counterList);
      _sharedController.saveData(counterList, _uid, _date);
      yield IncCounterState(counterList);
    }
  }
}
