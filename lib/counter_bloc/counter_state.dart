part of 'counter_bloc.dart';

@immutable
abstract class CounterState {
  int get blin =>0;
  int get suicide=>0;
  int get giveUp=>0;
  int get chetko=>0;
  String get uid=> '0';
}

class CounterInitial implements CounterState {
  CounterInitial();
  int get blin =>0;
  int get suicide=>0;
  int get giveUp=>0;
  int get chetko=>0;
  String get uid=> '0';
}

class IncCounter implements CounterState {

  IncCounter(this._blin, this._suicide, this._giveUp, this._chetko);

  final int _blin;
  final int _suicide;
  final int _giveUp;
  final int _chetko;

  String get uid=> '0';
  int get blin =>_blin;
  int get suicide=>_suicide;
  int get giveUp=>_giveUp;
  int get chetko=>_chetko;
}

class FirebaseUpdateState implements CounterState {

  FirebaseUpdateState(this._uid);
  final String _uid;
  final int _blin = 0;
  final int _suicide = 0;
  final int _giveUp=0;
  final int _chetko=0;

  String get uid => _uid;
  int get blin =>0;
  int get suicide=>0;
  int get giveUp=>0;
  int get chetko=>0;
}


