import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class TimeSeriesSymbolAnnotationChart extends StatelessWidget {
  TimeSeriesSymbolAnnotationChart(this._values, this._dates, this._animate);

  final List<List<int>> _values;
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
    final List<List<TimeSeriesClicks>> data = List.generate(
      _values.length,
      (ndx) => List.generate(
        _values[ndx].length,
        (index) => TimeSeriesClicks(
          _dates[index],
          _values[ndx][index],
        ),
      ),
    );

    return [
      Series<TimeSeriesClicks, DateTime>(
        id: 'Clicks',
        colorFn: (_, __) => MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesClicks clicks, _) => clicks.time,
        measureFn: (TimeSeriesClicks clicks, _) => clicks.clicks,
        data: data[0],
      ),
      Series<TimeSeriesClicks, DateTime>(
        id: 'Clicks',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesClicks clicks, _) => clicks.time,
        measureFn: (TimeSeriesClicks clicks, _) => clicks.clicks,
        data: data[1],
      ),
      Series<TimeSeriesClicks, DateTime>(
        id: 'Clicks',
        colorFn: (_, __) => MaterialPalette.yellow.shadeDefault,
        domainFn: (TimeSeriesClicks clicks, _) => clicks.time,
        measureFn: (TimeSeriesClicks clicks, _) => clicks.clicks,
        data: data[2],
      ),
      Series<TimeSeriesClicks, DateTime>(
        id: 'Clicks',
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesClicks clicks, _) => clicks.time,
        measureFn: (TimeSeriesClicks clicks, _) => clicks.clicks,
        data: data[3],
      ),
    ];
  }
}

class TimeSeriesClicks {
  TimeSeriesClicks(this.time, this.clicks);

  final DateTime time;
  final int clicks;
}
