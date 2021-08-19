part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {
  int get index => 0;
}

class Loading implements CounterEvent{
  Loading();

  int _index = -1;
  int get index => _index;
}

class IncCount implements CounterEvent{
  IncCount(this._index);

  int _index;
  int get index => _index;
}


