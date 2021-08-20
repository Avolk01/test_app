import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:register_page/models/firebase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc(this._controller, this._uid, this._timeNow, this._isNewUser, this._isNewDate)
      : super(CounterInitial()) {
    if (_isNewUser)
      _controller.createNewUser(_uid, _timeNow);
    else if (_isNewDate)
      _controller.addNewDate(_uid, _timeNow);
  }

  FirebaseController _controller;
  bool _isNewDate;
  bool _isNewUser;
  String _timeNow;
  String _uid;

  List<int> _databaseValues = [];
  List<int> _counterValues = [0,0,0,0];

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

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event.index == -1) {
      _databaseValues = await _controller.initFieldsFromDatabase(_uid, _timeNow);
      yield IncCounter(_databaseValues[0], _databaseValues[1],
          _databaseValues[2], _databaseValues[3]);
    } else {
      if (event.index < 5 && event.index > 0) _incCounter(event.index);
      List<int> counterList = _twoListSum(_databaseValues, _counterValues);
      _controller.updateDatabase(_uid, _timeNow, counterList);
      yield IncCounter(
        counterList[0],
        counterList[1],
        counterList[2],
        counterList[3],
      );
    }
  }
}
