import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:register_page/models/firebase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc(
    this._controller,
    this._uid,
    this._timeNow,
    this._isNewUser,
  ) : super(CounterInitial()) {
    if (_isNewUser) _controller.createNewUser(_uid, _timeNow);
    add(Loading());
  }

  FirebaseController _controller;
  bool _isNewUser;
  String _timeNow;
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

  void saveData(List<int> counterValues) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('blin', counterValues[0]);
    prefs.setInt('suicide', counterValues[1]);
    prefs.setInt('giveUp', counterValues[2]);
    prefs.setInt('chetko', counterValues[3]);
    prefs.setString('uid', _uid);
    prefs.setString('date', _timeNow);
  }

  Future<bool> isNewDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('date') != _timeNow;
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('date') == _timeNow) {
      _databaseValues[0] = (prefs.getInt('blin')!);
      _databaseValues[1] = (prefs.getInt('suicide')!);
      _databaseValues[2] = (prefs.getInt('giveUp')!);
      _databaseValues[3] = (prefs.getInt('chetko')!);
    }
  }

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event.index == -1) {
      if (!_isNewUser && !await isNewDate()) await loadData();
      else {
        _controller.addNewDate(_uid, _timeNow);
      }
      yield IncCounter(
        _databaseValues[0],
        _databaseValues[1],
        _databaseValues[2],
        _databaseValues[3],
      );
    } else {
      if (event.index < 5 && event.index > 0) _incCounter(event.index);
      List<int> counterList = _twoListSum(_databaseValues, _counterValues);
      _controller.updateDatabase(_uid, _timeNow, counterList);
      saveData(counterList);
      yield IncCounter(
        counterList[0],
        counterList[1],
        counterList[2],
        counterList[3],
      );
    }
  }
}
