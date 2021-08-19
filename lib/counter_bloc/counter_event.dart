part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {
  int get index => 0;
}

class IncCount implements CounterEvent{
  IncCount(this._index);

  int _index;
  int get index => _index;
}
