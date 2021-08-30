part of 'counter_bloc.dart';

@immutable
abstract class CounterState {
  int get blin => 0;
  int get suicide => 0;
  int get giveUp => 0;
  int get chetko => 0;
}

class CounterInitial implements CounterState {
  CounterInitial();
  int get blin => 0;
  int get suicide => 0;
  int get giveUp => 0;
  int get chetko => 0;
}

class LoadingState extends CounterState {
  LoadingState();
}

class IncCounterState extends CounterState {
  IncCounterState(this._values);
  final List<int> _values;
  int get blin => _values[0];
  int get suicide => _values[1];
  int get giveUp =>_values[2];
  int get chetko => _values[3];
}

class InitData implements CounterState {
  InitData(this._values);

  final List<int> _values;

  int get blin => _values[0];
  int get suicide => _values[1];
  int get giveUp => _values[2];
  int get chetko => _values[3];
}

class GraphData implements CounterState {
  GraphData(this._values, this._clicks, this._dates);
  final List<int> _values;
  final List<DateTime> _dates;
  final List<int> _clicks;
  int get blin => _values[0];
  int get suicide => _values[1];
  int get giveUp => _values[2];
  int get chetko => _values[3];
  List<int> get values => _clicks;
  List<DateTime> get dates => _dates;
}

class GraphDataAll extends CounterState {
  GraphDataAll(this._values, this._clicks, this._dates);
  final List<int> _values;
  final List<DateTime> _dates;
  final List<List<int>> _clicks;
  int get blin => _values[0];
  int get suicide => _values[1];
  int get giveUp => _values[2];
  int get chetko => _values[3];
  List<List<int>> get values => _clicks;
  List<DateTime> get dates => _dates;
}
