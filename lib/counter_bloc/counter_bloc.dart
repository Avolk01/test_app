import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
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
    this._isNewUser,
  ) : super(CounterInitial()) {
    if (_isNewUser) _controller.createNewUser(_uid, _date);
    add(Loading());
  }

  SharedPrefController _sharedController;
  FirebaseController _controller;
  bool _isNewUser;
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
    if (_isNewUser) {
      _sharedController.loadLocalData();
    } else {
      _databaseValues =
          await _controller.initFieldsFromDatabase(_uid, _date);
      _sharedController.setString('uid', _uid);
    }
  }

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is Loading) {
      if (!_isNewUser)
        await loadData();
      else {
        _controller.addNewDate(_uid, _date);
      }
      var dates = await _controller.getListOfDates(_uid);
      var x = await _controller.getListOfDateTime(_uid);
      var y = await _controller.getClicks(
          _uid, dates);
      yield GraphData(
        _databaseValues[0],
        _databaseValues[1],
        _databaseValues[2],
        _databaseValues[3],
        y,
        x,
      );
    } else {
      if (event.index < 5 && event.index > 0) _incCounter(event.index);
      List<int> counterList = _twoListSum(_databaseValues, _counterValues);
      _controller.updateDatabase(_uid, _date, counterList);
      _sharedController.saveData(counterList, _uid, _date);
      yield IncCounter(
        counterList[0],
        counterList[1],
        counterList[2],
        counterList[3],
      );
    }
  }
}
