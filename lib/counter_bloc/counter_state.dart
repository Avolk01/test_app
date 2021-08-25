part of 'counter_bloc.dart';
@immutable
abstract class CounterState {
  int get blin =>0;
  int get suicide=>0;
  int get giveUp=>0;
  int get chetko=>0;
  int get index =>0;
}

class CounterInitial implements CounterState {
  CounterInitial();

  int get index =>0;
  int get blin =>0;
  int get suicide=>0;
  int get giveUp=>0;
  int get chetko=>0;
}

class IncCounter implements CounterState {

  IncCounter(this._blin, this._suicide, this._giveUp, this._chetko);

  final int _blin;
  final int _suicide;
  final int _giveUp;
  final int _chetko;

  int get index => 0;
  int get blin =>_blin;
  int get suicide=>_suicide;
  int get giveUp=>_giveUp;
  int get chetko=>_chetko;
}

class InitData implements CounterState {

  InitData(this._blin, this._suicide, this._giveUp, this._chetko);

  final int _blin;
  final int _suicide;
  final int _giveUp;
  final int _chetko;

  int get index => -1;
  int get blin => _blin;
  int get suicide=> _suicide;
  int get giveUp=> _giveUp;
  int get chetko=> _chetko;
}

class GraphData implements CounterState {
  GraphData(this._blin, this._suicide, this._giveUp, this._chetko, this._values, this._dates);

  final int _blin;
  final int _suicide;
  final int _giveUp;
  final int _chetko;
  final List<DateTime> _dates;
  final List<int> _values;

  int get index => -1;
  int get blin => _blin;
  int get suicide=> _suicide;
  int get giveUp=> _giveUp;
  int get chetko=> _chetko;

  List<int> get values => _values;
  List<DateTime> get dates => _dates;
}


