part of 'statistic_bloc.dart';

@immutable
abstract class StatisticEvent {}

class GetDates implements StatisticEvent{
  GetDates();
}
