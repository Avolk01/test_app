part of 'statistic_bloc.dart';

@immutable
abstract class StatisticEvent {
  String get key =>'0';
  String get date =>'0';
}

class GetDates implements StatisticEvent{
  GetDates();
  String get key =>'dates';
  String get date =>'0';
}

class GetValues implements StatisticEvent{
  GetValues(this._date);
  String _date;
  String get key =>'values';
  String get date =>_date;
}
