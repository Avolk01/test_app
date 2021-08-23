part of 'statistic_bloc.dart';

@immutable
abstract class StatisticState {
  List<String> get dates => [];
}

class StatisticInitial extends StatisticState {}

class Dates implements StatisticState{
  Dates(this._dates);

  List<String> _dates;
  List<String> get dates =>_dates;
}