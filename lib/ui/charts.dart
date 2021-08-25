import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  SimpleTimeSeriesChart(this._values, this._dates, this._animate) {}

  final List<int> _values;
  final List<DateTime> _dates;
  final bool _animate;

  @override
  Widget build(BuildContext context) {
    return new TimeSeriesChart(
      _createData(),
      animate: _animate,
      dateTimeFactory: const LocalDateTimeFactory(),
    );
  }

  List<Series<TimeSeriesClicks, DateTime>> _createData() {
    final List<TimeSeriesClicks> data = List.generate(
      _values.length,
      (index) => TimeSeriesClicks(
        _dates[index],
        _values[index],
      ),
    );

    return [
      Series<TimeSeriesClicks, DateTime>(
        id: 'Clicks',
        colorFn: (_,__) => MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesClicks clicks, _) => clicks.time,
        measureFn: (TimeSeriesClicks clicks, _) => clicks.clicks,
        data: data,
      )
    ];
  }
}

class TimeSeriesClicks {
  TimeSeriesClicks(this.time, this.clicks);

  final DateTime time;
  final int clicks;
}
