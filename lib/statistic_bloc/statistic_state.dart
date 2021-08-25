part of 'statistic_bloc.dart';

@immutable
abstract class StatisticState {
  List<int> get values => [];
  List<String> get dates => [];
}

class StatisticInitial extends StatisticState {}

class Dates extends StatisticState {
  Dates(this._dates);

  List<String> _dates;
  List<String> get dates => _dates;
}

class Values extends StatisticState {
  Values(this._values);

  List<int> _values;
  List<int> get values => _values;
}
