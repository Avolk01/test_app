import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc(this._uid, this._timeNow, this._isNewUser) : super(CounterInitial()) {
    if(_isNewUser)
      createNewUser(_uid, _timeNow);
    initFieldsFromDatabase(_uid, _timeNow);
  }

  void initFieldsFromDatabase(String uid, String time) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('dates')
        .doc(time)
        .get()
        .then((value) {
      _blinCounterDatabase = value['blin'];
      _chetkoCounterDatabase = value['chetko'];
      _giveUpCounterDatabase = value['giveUp'];
      _suicideCounterDatabase = value['suicide'];
    });
  }

  bool _isNewUser;
  String _timeNow;
  String _uid;

  int _blinCounterDatabase = 0;
  int _suicideCounterDatabase = 0;
  int _giveUpCounterDatabase = 0;
  int _chetkoCounterDatabase = 0;

  int _blinCounter = 0;
  int _suicideCounter = 0;
  int _giveUpCounter = 0;
  int _chetkoCounter = 0;

  void createNewUser(String uid, String time) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('dates')
        .doc(time)
        .set({'blin': 0, 'suicide': 0, 'giveUp': 0, 'chetko': 0});
  }

  void _incCounter(int index) {
    switch (index) {
      case 1:
        _blinCounter++;
        break;
      case 2:
        _suicideCounter++;
        break;
      case 3:
        _giveUpCounter++;
        break;
      case 4:
        _chetkoCounter++;
        break;
    }
  }

  void updateDatabase(String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('dates')
        .doc(_timeNow)
        .update({
      'blin': _blinCounter + _blinCounterDatabase,
      'suicide': _suicideCounter + _suicideCounterDatabase,
      'giveUp': _giveUpCounter + _giveUpCounterDatabase,
      'chetko': _chetkoCounter + _chetkoCounterDatabase,
    });
  }

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event.index < 5) _incCounter(event.index);
    updateDatabase(_uid);

    yield IncCounter(
        _blinCounter + _blinCounterDatabase,
        _suicideCounter + _suicideCounterDatabase,
        _giveUpCounter + _giveUpCounterDatabase,
        _chetkoCounter + _chetkoCounterDatabase);
  }
}
